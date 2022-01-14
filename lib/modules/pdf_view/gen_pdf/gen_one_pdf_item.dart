import 'package:class_grades_analyzer/data/model/dimensions/tab_names.dart';
import 'package:class_grades_analyzer/data/model/grade_or_rank.dart';
import 'package:class_grades_analyzer/data/model/one_exam_model.dart';
import 'package:class_grades_analyzer/data/model/pdf/one_pdf_declarer.dart';
import 'package:class_grades_analyzer/data/model/pdf/pdf_item_type.dart';
import 'package:class_grades_analyzer/modules/pdf_view/gen_pdf/functions/get_inds.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../pdf_view_controller.dart';
import 'functions/make_pdf_chart.dart';
import 'functions/make_pdf_table.dart';

pw.Widget genOnePdfItem(PdfPageFormat format, PdfViewController ctrler,
    dynamic mainInd, OnePdfDeclarerModel itemDeclarer) {
  final children = <pw.Widget>[];

  // * 1. Get data
  // #region 1.1 For Inds
  final axes = ctrler.axes.value;
  final xFor = (itemDeclarer.exchangeXY) ? axes.y : axes.x;
  final yFor = (itemDeclarer.exchangeXY) ? axes.x : axes.y;
  final mainFor = axes.main;

  String examInd = "";
  dynamic studentInd = "";
  String courseInd = "";

  var feedIndices = (TabsEnum indType, dynamic axisInd) {
    switch (indType) {
      case TabsEnum.exam:
        examInd = axisInd;
        break;
      case TabsEnum.student:
        studentInd = axisInd;
        break;
      case TabsEnum.course:
        courseInd = axisInd;
        break;
      default:
        assert(false, "feedIndices' indType does not exist");
    }
  };

  // #endregion 1.1 For Inds

  final exams = ctrler.gC.exams.value;
  final xInds = getInds(
      indType: itemDeclarer.xType,
      viewInds: ctrler.x,
      nStSelN: itemDeclarer.nx);
  final yInds = getInds(
      indType: itemDeclarer.yType,
      viewInds: ctrler.y,
      nStSelN: itemDeclarer.ny);
  final gType = itemDeclarer.gType;
  final List<List<dynamic>> data = [];

  final tableYinds = (itemDeclarer.exchangeXY) ? xInds : yInds;
  final tableXinds = (itemDeclarer.exchangeXY) ? yInds : xInds;

  feedIndices(mainFor, mainInd);
  for (var yInd in tableYinds) {
    feedIndices(yFor, yInd);
    final aRow = [];
    for (var xInd in tableXinds) {
      feedIndices(xFor, xInd);
      final grade =
          exams?.getExam(examInd).getStudent(studentInd).getCourse(courseInd);
      aRow.add((gType == GradeOrRankEnum.grade)
          ? (grade?.numb)
          : ((gType == GradeOrRankEnum.rank) ? grade?.rank : null));
    }
    data.add(aRow);
  }

  // TODO For showing the highest, lowest and average for each student
  if (mainFor == TabsEnum.student) {
    if (itemDeclarer.showHLA && axes.y == TabsEnum.exam) {
      final exam_01_ind = yInds[0];
      final highestRow = <num?>[];
      final lowestRow = <num?>[];
      final averageRow = <num?>[];
      for (var xInd in tableXinds) {
        feedIndices(xFor, xInd);
        final highest = exams
            ?.getExam(exam_01_ind)
            .getStudent({VStudentKeys.highest: null}).getCourse(courseInd);
        final lowest = exams
            ?.getExam(exam_01_ind)
            .getStudent({VStudentKeys.lowest: null}).getCourse(courseInd);
        final average = exams
            ?.getExam(exam_01_ind)
            .getStudent({VStudentKeys.average: null}).getCourse(courseInd);
        highestRow.add(highest?.numb);
        lowestRow.add(lowest?.numb);
        averageRow.add(average?.numb);
      }
      data.add(highestRow);
      yInds.add(VStudentKeys.highest);
      data.add(lowestRow);
      yInds.add(VStudentKeys.lowest);
      data.add(averageRow);
      yInds.add(VStudentKeys.average);
    }
  }

  // 2. Draw table
  var theItem;
  if (itemDeclarer.type == PdfItemTypeEnum.table ||
      itemDeclarer.type == PdfItemTypeEnum.tbl_chart) {
    theItem = makePdfTable(xFor, tableXinds, yFor, tableYinds, data);
    children.add(
      pw.Expanded(
        child: pw.Padding(
            padding: pw.EdgeInsets.all(8),
            child: pw.Align(
              alignment: pw.Alignment.topCenter,
              child: theItem,
            )),
      ),
    );
  }

  // 3. Draw chart
  if (itemDeclarer.type == PdfItemTypeEnum.lineChart ||
      itemDeclarer.type == PdfItemTypeEnum.tbl_chart) {
    theItem = makePdfChart(xFor, tableXinds, yFor, tableYinds, data);
    children.add(pw.Expanded(
      child: pw.Padding(
        padding: pw.EdgeInsets.all(8),
        child: theItem,
      ),
    ));
  }

  pw.Widget result = pw.Column(children: children);
  return result;
}
