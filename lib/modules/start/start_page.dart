import 'dart:convert';

import 'package:class_grades_analyzer/controllers/exams_controller.dart';
import 'package:class_grades_analyzer/controllers/id_and_course_keys_controller.dart';
import 'package:class_grades_analyzer/controllers/my_global_controller.dart';
import 'package:class_grades_analyzer/data/provider/from_excel_file/index.dart';
import 'package:class_grades_analyzer/data/repository/get_exams.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StartPage extends StatelessWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: Text("Get an Excel File"),
        onPressed: getExams,
      ),
    );
  }

  getExams() async {
    final c = Get.find<ExamsController>();
    var examRepo = GetExamsRepository(FromExcelFileApi());
    var result = await examRepo.getExamsAsync();
    c.exams.value = result; // trigger the ExamsController

    debugPrint(jsonEncode(result));
    final gC = Get.find<MyGlobalController>();
    debugPrint("ids: ${jsonEncode(gC.currentIds)}");
    debugPrint("courses: ${jsonEncode(gC.currentCourseKeys)}");
    debugPrint("exams: ${jsonEncode(gC.currentExamKeys)}");
    return result;
  }
}
