import 'package:class_grades_analyzer/controllers/id_and_course_keys_controller.dart';
import 'package:class_grades_analyzer/modules/start/UI/end_row.dart';
import 'package:class_grades_analyzer/modules/start/UI/ignore_sheets_setter.dart';
import 'package:class_grades_analyzer/modules/start/UI/student_id_setter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'course_key_setter.dart';

class SettingsForAll extends StatelessWidget {
  const SettingsForAll({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        theTitle(),
        StudentIDSetter(),
        CourseKeySetter(),
        EndRow(),
        IgnoreSheetsSetter(),
      ],
    );
  }
}

Widget theTitle() {
  final c = Get.find<IdAndCourseKeysController>();
  return Stack(
    children: [
      Container(
        alignment: Alignment.topCenter,
        padding: EdgeInsets.all(8),
        child: Text("載入前設定"),
      ),
      Positioned(
          right: 8,
          child: IconButton(
              onPressed: () => c.write2GetStorage(), icon: Icon(Icons.archive)))
    ],
  ); // I18N
}
