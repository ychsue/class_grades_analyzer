import 'package:class_grades_analyzer/controllers/global_var/update_v_course_names.dart';
import 'package:class_grades_analyzer/controllers/id_and_course_keys_controller.dart';
import 'package:class_grades_analyzer/data/model/one_exam_row_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SpecialFieldsName extends GetView<IdAndCourseKeysController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(8, 1, 8, 1),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.cyan[100],
        border: Border.all(),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: // Obx(() =>
          ExpansionTile(
        title: Center(child: Text("設定特殊欄位名")), // I18N
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    initialValue: controller.avgName.value,
                    onChanged: (v) {
                      controller.avgName.value = v;
                      updateVCourseNames();
                    },
                    decoration: InputDecoration(
                        hintText: VCourseNames.average,
                        labelText: "平均"), // I18N
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    initialValue: controller.sumName.value,
                    onChanged: (v) {
                      controller.sumName.value = v;
                      updateVCourseNames();
                    },
                    decoration: InputDecoration(
                        hintText: VCourseNames.sum, labelText: "總分"), // I18N
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    initialValue: controller.avgAllName.value,
                    onChanged: (v) {
                      controller.avgAllName.value = v;
                    },
                    decoration: InputDecoration(
                        hintText: controller.avgAllName.value,
                        labelText: "總平均"), // I18N
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    initialValue: controller.highestName.value,
                    onChanged: (v) {
                      controller.highestName.value = v;
                    },
                    decoration: InputDecoration(
                        hintText: controller.highestName.value,
                        labelText: "最高分"), // I18N
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    initialValue: controller.lowestName.value,
                    onChanged: (v) {
                      controller.lowestName.value = v;
                    },
                    decoration: InputDecoration(
                        hintText: controller.lowestName.value,
                        labelText: "最低分"), // I18N
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      // ),
    );
  }
}
