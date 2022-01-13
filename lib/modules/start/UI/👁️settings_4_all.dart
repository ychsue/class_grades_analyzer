import 'package:class_grades_analyzer/modules/start/UI/end_row.dart';
import 'package:class_grades_analyzer/modules/start/UI/ignore_sheets_setter.dart';
import 'package:class_grades_analyzer/modules/start/UI/special_fields_name.dart';
import 'package:class_grades_analyzer/modules/start/UI/student_id_setter.dart';
import 'package:flutter/material.dart';

import 'course_key_setter.dart';

class SettingsForAll extends StatelessWidget {
  const SettingsForAll({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        StudentIDSetter(),
        CourseKeySetter(),
        EndRow(),
        IgnoreSheetsSetter(),
        SpecialFieldsName(),
      ],
    );
  }
}
