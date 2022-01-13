import 'package:class_grades_analyzer/controllers/id_and_course_keys_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EndRow extends StatefulWidget {
  EndRow({Key? key}) : super(key: key);

  @override
  _EndRowState createState() => _EndRowState();
}

class _EndRowState extends State<EndRow> {
  final controller = Get.find<IdAndCourseKeysController>();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

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
      child: Obx(() => ExpansionTile(
            title: Center(child: Text("開始忽略的欄位值")),
            children: [
              Form(
                child: TextFormField(
                  initialValue: controller.endRow.value,
                  onChanged: (v) => controller.endRow.value = v,
                  decoration: InputDecoration(helperText: "開始忽略的欄位值"), // I18N
                ),
              ),
            ],
          )),
    );
  }
}
