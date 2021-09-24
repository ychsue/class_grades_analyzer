import 'package:class_grades_analyzer/data/model/dimensions/dims_model.dart';
import 'package:class_grades_analyzer/data/model/dimensions/each_case_model.dart';
import 'package:class_grades_analyzer/data/model/dimensions/tab_names.dart';
import 'package:class_grades_analyzer/data/model/exams_model.dart';
import 'package:class_grades_analyzer/data/model/grade_or_rank.dart';
import 'package:class_grades_analyzer/data/model/pdf/main_pdf_declarer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf/widgets.dart' as pw;

class MyGlobalController extends GetxController {
  static const Map<String, Icon> Tabs = {
    TabNames.home: Icon(Icons.home),
    TabNames.exam: Icon(Icons.description),
    TabNames.student: Icon(Icons.person),
    TabNames.course: Icon(Icons.auto_stories),
  };

  pw.TtfFont? ttf;

  DimsModel allAxes = DimsModel();
  Set<Rx<EachCaseModel>> cases = {
    EachCaseModel(main: TabsEnum.exam, x: TabsEnum.course, y: TabsEnum.student)
        .obs,
    EachCaseModel(main: TabsEnum.student, x: TabsEnum.course, y: TabsEnum.exam)
        .obs,
    EachCaseModel(main: TabsEnum.course, x: TabsEnum.exam, y: TabsEnum.student)
        .obs,
  };

  Rx<ExamsModel?> exams = (null as ExamsModel).obs;
  Rx<TabsEnum> tab = (TabsEnum.home).obs;

  // For showing grade or rank
  final gType = GradeOrRankEnum.grade.obs;
  final gNames = GradeOrRankModel(gradeName: "成績", rankName: "名次")
      .obs; //If you want to set it, provide a new one.

  // For PDF
  final List<Rx<MainPdfDeclarerModel>> allMainPdfDeclares =
      <Rx<MainPdfDeclarerModel>>[
    (MainPdfDeclarerModel(main: TabsEnum.exam)
          ..headerScript = "\$1班 第\$2學期 第\$3次月考")
        .obs, //I18N
    MainPdfDeclarerModel(main: TabsEnum.student).obs,
    MainPdfDeclarerModel(main: TabsEnum.course).obs,
  ];
}
