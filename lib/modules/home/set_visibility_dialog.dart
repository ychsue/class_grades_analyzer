import 'dart:convert';

import 'package:class_grades_analyzer/controllers/my_global_controller.dart';
import 'package:class_grades_analyzer/data/model/dimensions/each_case_model.dart';
import 'package:class_grades_analyzer/data/model/dimensions/tab_names.dart';
import 'package:class_grades_analyzer/data/model/pair.dart';
import 'package:class_grades_analyzer/modules/home/mytab_controller.dart';
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

    bool? chk4AllShouldbe() {
      return (currentAxis == null)
          ? null
          : ((currentAxis.every((ele) => ele.t2)
              ? true
              : (currentAxis.every((ele) => ele.t2 == false) ? false : null)));
    }

    final c = chk4AllShouldbe().obs;
    return Container(child: Obx(
      () {
        return Dialog(
          elevation: 10,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: LimitedBox(
              maxWidth: 480,
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      color: Colors.lime,
                      padding: EdgeInsets.fromLTRB(0, 24, 24, 0),
                      child: ListTile(
                        key: UniqueKey(),
                        leading: Checkbox(
                            tristate: true,
                            value: c.value,
                            onChanged: (v) {
                              debugPrint("Axis: $v");
                              c.value = v ?? false;
                              axes.value.toSelAll(
                                  axisEnum: whichAxis, isAll: c.value ?? false);
                              axes.refresh();
                            }),
                        title: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                  MyGlobalController
                                      .Tabs[TabNames.name(whichAxis)]?.icon,
                                  size: context.theme.textTheme.headline3
                                          ?.fontSize ??
                                      14),
                              SizedBox(width: 14),
                              Text(
                                TabNames.name(whichAxis),
                                style: context.theme.textTheme.headline3,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Divider(),
                    Expanded(
                      child: ReorderableListView(
                          children: [
                            if (currentAxis != null)
                              ...currentAxis.map((e) => ListTile(
                                  key: ValueKey(jsonEncode(e) +
                                      TabNames.name(axes.value.main)),
                                  leading: Checkbox(
                                    onChanged: (v) {
                                      e.t2 = !e.t2;
                                      c.value =
                                          chk4AllShouldbe();
                                      axes.refresh();
                                      debugPrint("${jsonEncode(e)}");
                                    },
                                    value: e.t2,
                                  ),
                                  title: Text(jsonEncode(e.t1))))
                            else
                              ...[]
                          ],
                          onReorder: (o, n) {
                            currentAxis?.insert(n, currentAxis[o]);
                            currentAxis?.removeAt((o > n) ? (o + 1) : o);
                            axes.refresh();
                          }),
                    ),
                  ]),
            ),
          ),
        );
      },
    ));
  }
}
