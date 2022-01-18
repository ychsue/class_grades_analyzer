import 'dart:convert';

import 'package:class_grades_analyzer/controllers/exams_controller.dart';
// import 'package:class_grades_analyzer/controllers/my_global_controller.dart';
import 'package:class_grades_analyzer/data/provider/from_excel_file/index.dart';
import 'package:class_grades_analyzer/data/repository/get_exams.dart';
// import 'package:flutter/material.dart';
import 'package:get/get.dart';

getExams() async {
  final c = Get.find<ExamsController>();
  var examRepo = GetExamsRepository(FromExcelFileApi());
  var result = await examRepo.getExamsAsync();
  c.exams.value = result; // trigger the ExamsController

  // debugPrint(jsonEncode(result));
  // final gC = Get.find<MyGlobalController>();
  // debugPrint("ids: ${jsonEncode(gC.allAxes.student)}");
  // debugPrint("courses: ${jsonEncode(gC.allAxes.course)}");
  // debugPrint("exams: ${jsonEncode(gC.allAxes.exam)}");
  return result;
}
