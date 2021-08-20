import 'dart:convert';

import 'package:class_grades_analyzer/controllers/exam_controller.dart';
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
    final c = Get.find<ExamController>();
    var examRepo = GetExamsRepository(FromExcelFileApi());
    var result = await examRepo.getExamsAsync();
    c.exams.value = result; // trigger the ExamController

    debugPrint(jsonEncode(result));
    return result;
  }
}
