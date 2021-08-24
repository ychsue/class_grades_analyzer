import 'package:class_grades_analyzer/data/model/dimensions/tab_names.dart';
import 'package:class_grades_analyzer/data/model/exams_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyGlobalController extends GetxController {
  static const Map<String, Icon> Tabs = {
    TabNames.home: Icon(Icons.home),
    TabNames.exam: Icon(Icons.description),
    TabNames.student: Icon(Icons.person),
    TabNames.course: Icon(Icons.auto_stories),
  };

  List<Map<String, dynamic>> currentIds = [];
  List<String> currentCourseKeys = [];
  List<String> currentExamKeys = [];



  Rx<ExamsModel?> exams = (null as ExamsModel).obs;
  RxString tab = (TabNames.home).obs;
}

