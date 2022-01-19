import 'package:class_grades_analyzer/data/model/dimensions/dims_model.dart';
import 'package:class_grades_analyzer/data/model/dimensions/each_case_model.dart';
import 'package:class_grades_analyzer/data/model/dimensions/tab_names.dart';
import 'package:class_grades_analyzer/data/model/exams_model.dart';
import 'package:class_grades_analyzer/data/model/grade_or_rank.dart';
import 'package:class_grades_analyzer/data/model/pdf/ind_declare_enum.dart';
import 'package:class_grades_analyzer/data/model/pdf/main_pdf_declarer.dart';
import 'package:class_grades_analyzer/data/model/pdf/one_pdf_declarer.dart';
import 'package:class_grades_analyzer/data/model/pdf/pdf_item_type.dart';
import 'package:class_grades_analyzer/data/provider/for_pdf_declarer.dart';
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
  bool get hasData => exams.value != null;
  Rx<TabsEnum> tab = (TabsEnum.home).obs;

  // For showing grade or rank
  final gType = GradeOrRankEnum.grade.obs;
  final gNames = GradeOrRankModel(gradeName: "成績", rankName: "名次")
      .obs; //If you want to set it, provide a new one.

  // For PDF
  late List<Rx<MainPdfDeclarerModel>> allMainPdfDeclares;

  @override
  void onInit() {
    super.onInit();

    // initialize 3 MainPdfDeclarers
    allMainPdfDeclares = <Rx<MainPdfDeclarerModel>>[
      (MainPdfDeclarerModel(main: TabsEnum.exam)
            ..headerScript = "\$1班 第\$2學期 第\$3次月考"
            ..children = [OnePdfDeclarerModel()..yType = IndDeclarerEnum.all])
          .obs, //I18N
      (MainPdfDeclarerModel(main: TabsEnum.student)
            ..headerScript = "座號：\$1，姓名：\$2"
            ..children = [
              OnePdfDeclarerModel()
                ..type = PdfItemTypeEnum.table
                ..showHLA = true
                ..stSelY = "1~2"
                ..ny = [1, 2],
              OnePdfDeclarerModel()
                ..type = PdfItemTypeEnum.lineChart
                ..exchangeXY = true
                ..xType = IndDeclarerEnum.selN
                ..stSelX = "7"
                ..yType = IndDeclarerEnum.all
            ]
            ..indType = IndDeclarerEnum.all)
          .obs,
      (MainPdfDeclarerModel(main: TabsEnum.course)
            ..indType = IndDeclarerEnum.all
            ..children = [OnePdfDeclarerModel()..yType = IndDeclarerEnum.all])
          .obs,
    ];
    // update it if possible
    ForPDFDeclarer.load().then((loadData) {
      if (loadData != null)
        allMainPdfDeclares.forEach((ele1) {
          ele1.value =
              loadData.firstWhere((ele2) => ele2.main == ele1.value.main);
        });
    });
  }
}
