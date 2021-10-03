import 'package:class_grades_analyzer/data/model/dimensions/tab_names.dart';
import 'package:class_grades_analyzer/data/model/grade_or_rank.dart';
import 'package:class_grades_analyzer/data/model/pdf/one_pdf_declarer.dart';
import 'package:class_grades_analyzer/data/model/pdf/pdf_item_type.dart';
import 'package:class_grades_analyzer/modules/dims/dims_controller.dart';
import 'package:class_grades_analyzer/modules/pdf_view/gen_pdf/functions/get_inds.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
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
  final xFor = axes.x;
  final yFor = axes.y;
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
      indType: itemDeclarer.xType, viewInds: ctrler.x, n: itemDeclarer.nx);
  final yInds = getInds(
      indType: itemDeclarer.yType, viewInds: ctrler.y, n: itemDeclarer.ny);
  final gType = itemDeclarer.gType;
  final List<List<dynamic>> data = [];

  final tableYinds = (itemDeclarer.exchangeXY) ? xInds : yInds;
  final tableXinds = (itemDeclarer.exchangeXY) ? yInds : xInds;

  feedIndices(mainFor, mainInd);
  for (var yInd in tableYinds) {
    feedIndices((itemDeclarer.exchangeXY) ? xFor : yFor, yInd);
    final aRow = [];
    for (var xInd in tableXinds) {
      feedIndices((itemDeclarer.exchangeXY) ? yFor : xFor, xInd);
      final grade =
          exams?.getExam(examInd).getStudent(studentInd).getCourse(courseInd);
      aRow.add((gType == GradeOrRankEnum.grade)
          ? (grade?.numb)
          : ((gType == GradeOrRankEnum.rank) ? grade?.rank : null));
    }
    data.add(aRow);
  }

  // 2. Draw table
  var theItem;
  if (itemDeclarer.type == PdfItemTypeEnum.table ||
      itemDeclarer.type == PdfItemTypeEnum.tbl_chart) {
    theItem = makePdfTable(xFor, tableXinds, yFor, tableYinds, data);
    children.add(pw.Expanded(
      child: theItem,
    ));
  }

  // 3. Draw chart
  if (itemDeclarer.type == PdfItemTypeEnum.lineChart ||
      itemDeclarer.type == PdfItemTypeEnum.tbl_chart) {
    theItem = makePdfChart(xFor, tableXinds, yFor, tableYinds, data);
    children.add(pw.Expanded(
      child: theItem,
    ));
  }

  children.add(pw.Text("${ctrler.currentDeclare.value.bottomScript}"));
  pw.Widget result = pw.Column(children: children);
  return result;
}
