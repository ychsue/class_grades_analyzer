import 'package:class_grades_analyzer/data/model/dimensions/dims_model.dart';
import 'package:class_grades_analyzer/data/model/dimensions/each_case_model.dart';
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

  DimsModel allAxes = DimsModel();
  Set<Rx<EachCaseModel>> caseShows = {
    EachCaseModel(main: TabsEnum.exam, x: TabsEnum.course, y: TabsEnum.student)
        .obs,
    EachCaseModel(main: TabsEnum.student, x: TabsEnum.course, y: TabsEnum.exam)
        .obs,
    EachCaseModel(main: TabsEnum.course, x: TabsEnum.exam, y: TabsEnum.student)
        .obs,
  };

  Rx<ExamsModel?> exams = (null as ExamsModel).obs;
  Rx<TabsEnum> tab = (TabsEnum.home).obs;
}
