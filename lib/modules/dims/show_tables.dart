import 'package:class_grades_analyzer/data/model/dimensions/dim_ind_types.dart';
import 'package:class_grades_analyzer/data/model/dimensions/each_case_model.dart';
import 'package:class_grades_analyzer/data/model/dimensions/tab_names.dart';
import 'package:class_grades_analyzer/data/model/pair.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShowTables extends StatelessWidget {
  const ShowTables(
      {Key? key, required this.inds, required this.data, required this.axes})
      : super(key: key);
  final DimsIndTypes<List<PairModel<dynamic, bool>>> inds;
  final List<List<List<dynamic>>> data;
  final Rx<EachCaseModel> axes;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Obx(() => LimitedBox(
              maxWidth: (MediaQuery.of(context).size.width > inds.x.length * 80)
                  ? MediaQuery.of(context).size.width
                  : inds.x.length * 80,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: getTables(),
              ),
            )),
      ),
    );
  }

  List<Widget> getTables() {
    List<Widget> result = [];
    if (inds.main.length == 0 || inds.x.length == 0 || inds.y.length == 0)
      return [];
      
    for (var iMain = 0; iMain < inds.main.length; iMain++) {
      final List<Widget> aTable = [];
      aTable.add(
        AppBar(
          title: Center(child: Text("${inds.main[iMain].t1}")),
          automaticallyImplyLeading: false,
        ),
      ); // Each Main

      List<num?> minMax = getMinMax(data[iMain]);

      aTable.add(DataTable(
        columnSpacing: 0,
        columns: genColumns(),
        rows: [
          for (var iy = 0; iy < inds.y.length; iy++)
            genDataRow(iMain: iMain, iy: iy, minMax: minMax)
        ],
      ));

      result.add(Container(
        padding: EdgeInsets.all(8.0),
        margin: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            border: Border.all(), borderRadius: BorderRadius.circular(8.0)),
        child: Column(
          children: aTable,
        ),
      ));
    }
    return result;
  }

  /// The result is [min,max]
  ///
  List<num?> getMinMax(List<List<dynamic>> aTable) {
    List<num?> result = [null, null]; //min, max
    void setMinMax(num input) {
      result[0] ??= input;
      result[1] ??= input;
      if (input > result[1]!) result[1] = input;
      if (input < result[0]!) result[0] = input;
    }

    aTable.forEach((eR) {
      eR.forEach((eC) {
        if (eC is num) {
          setMinMax(eC);
        } else if (eC != null && num.tryParse(eC) != null) {
          setMinMax(num.tryParse(eC)!);
        }
      });
    });

    return result;
  }

  List<DataColumn> genColumns() {
    final List<String> stCols = [];
    final List<DataColumn> result = [];
    final sortIndices = axes.value.sortIndices;
    switch (axes.value.y) {
      case TabsEnum.student:
        final students = sortIndices.student;
        if (students.length != 0) {
          result.add(
            DataColumn(
              label: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [for (var key in students[0].t1.keys) Text(key)],
              ),
            ),
          );
        }
        break;
      case TabsEnum.course:
        stCols.add('course');
        break;
      case TabsEnum.exam:
        stCols.add('exam');
        break;
      default:
    }
    stCols.addAll(inds.x.map((e) => e.t1.toString()));
    result.addAll(stCols
        .map((e) => DataColumn(
                label: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(e),
            )))
        .toList());
    return result;
  }

  DataRow genDataRow(
      {required int iMain, required int iy, required List<num?> minMax}) {
    List<String> grades = [];
    List<DataCell> cells = [];
    final ys = inds.y;
    if (axes.value.y == TabsEnum.student) {
      cells.add(DataCell(
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [for (var item in ys[iy].t1.values) Text(item.toString())],
        ),
      ));
    } else {
      grades.add(ys[iy].t1.toString());
    }
    grades.addAll(data[iMain][iy].map((e) => e.toString()));

    cells.addAll(grades
        .map((e) => DataCell(
              Stack(
                children: [
                  Container(
                    color: getColor(e, minMax),
                  ),
                  Align(
                    child: Text(e),
                  ),
                ],
              ),
            ))
        .toList());
    return DataRow(cells: cells);
  }

  Color getColor(String e, List<num?> minMax) {
    if (num.tryParse(e) != null && minMax.every((ele) => ele != null)) {
      final val = num.parse(e);
      final del = minMax[1]! - minMax[0]!;
      return (del != 0)
          ? Color.lerp(Colors.grey, Colors.white, (val - minMax[0]!) / del) ??
              Colors.transparent
          : Colors.transparent;
    }
    return Colors.transparent;
  }
}
