import 'dart:convert';

import 'package:class_grades_analyzer/controllers/my_global_controller.dart';
import 'package:class_grades_analyzer/data/model/dimensions/each_case_model.dart';
import 'package:class_grades_analyzer/data/model/dimensions/tab_names.dart';
import 'package:class_grades_analyzer/data/model/pair.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SetVisibilityDialog extends StatelessWidget {
  const SetVisibilityDialog({
    Key? key,
    required this.axes,
    required this.whichAxis,
    required this.gC,
  }) : super(key: key);
  final Rx<EachCaseModel> axes;
  final MyGlobalController gC;
  final TabsEnum whichAxis;

  @override
  Widget build(BuildContext context) {
    late List<PairModel<dynamic, bool>>? currentAxis;
    switch (whichAxis) {
      case TabsEnum.exam:
        currentAxis = axes.value.sortIndices.exam;
        break;
      case TabsEnum.student:
        currentAxis = axes.value.sortIndices.student;
        break;
      case TabsEnum.course:
        currentAxis = axes.value.sortIndices.course;
        break;
      default:
        currentAxis = null;
    }

    final c = (currentAxis?.every((ele) => ele.t2) ?? false).obs;
    return Container(child: Obx(
      () {
        return SimpleDialog(
          titlePadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          title: Container(
            color: Colors.lime,
            padding: EdgeInsets.fromLTRB(0, 24, 24, 0),
            child: ListTile(
              key: UniqueKey(),
              leading: Checkbox(
                  value: c.value,
                  onChanged: (v) {
                    debugPrint("Axis: $v");
                    c.value = v ?? false;
                    axes.value.toSelAll(axisEnum: whichAxis, isAll: c.value);
                    axes.refresh();
                  }),
              title: Text(TabNames.name(whichAxis)),
            ),
          ),
          children: [
            Divider(),
            if (currentAxis != null)
              ...currentAxis.map((e) => ListTile(
                  key: ValueKey(jsonEncode(e) + TabNames.name(axes.value.main)),
                  leading: Checkbox(
                    onChanged: (v) {
                      e.t2 = !e.t2;
                      c.value = currentAxis?.every((ele) => ele.t2) ?? false;
                      axes.refresh();
                      debugPrint("${jsonEncode(e)}");
                    },
                    value: e.t2,
                  ),
                  title: Text(jsonEncode(e.t1))))
            else
              ...[]
          ],
        );
      },
    ));
  }
}
