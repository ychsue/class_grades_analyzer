import 'dart:typed_data';
import 'package:class_grades_analyzer/data/model/dimensions/tab_names.dart';
import 'package:class_grades_analyzer/data/model/pdf/ind_declare_enum.dart';
import 'package:class_grades_analyzer/data/model/pdf/one_pdf_declarer.dart';
import 'package:class_grades_analyzer/modules/pdf_view/pdf_view_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

Future<Uint8List> genPdfDoc(PdfPageFormat format, PdfViewController ctrler,
    [bool isOkay2Draw = false]) async {
  late pw.TtfFont ttf;
  try {
    if (ctrler.gC.ttf == null) {
      ctrler.gC.ttf = await fontFromAssetBundle("assets/wt001.ttf");
    }
    ttf = ctrler.gC.ttf!;
  } catch (e) {
    debugPrint(e.toString());
  }

  final theme = pw.ThemeData.withFont(base: ttf);
  final doc = pw.Document(title: TabNames.name(ctrler.gC.tab.value));

  // If it is not started, using the default one.
  if (isOkay2Draw == false) {
    doc.addPage(
      pw.Page(
        pageFormat: format,
        // theme: theme,
        build: (ctx) => pw.Center(
            child: pw.Text(
                //"What's wrong?",
                "請先按設定左邊三條線設定，或者，您得先載入相應的Excel檔才可以。謝謝。",
                style: pw.TextStyle(font: ttf))),
      ),
    );
    return doc.save();
  }

  // Now, draw each page
  // * 1. Get main Inds
  final currentDeclare = ctrler.currentDeclare.value;
  final mainIndType = currentDeclare.indType;
  late List<dynamic> mainInds;

  switch (mainIndType) {
    case IndDeclarerEnum.all:
      mainInds = ctrler.main.map((e) => e.t1).toList();
      break;
    case IndDeclarerEnum.asTableView:
      mainInds = ctrler.main.where((e) => e.t2).map((e) => e.t1).toList();
      break;
    case IndDeclarerEnum.firstN:
      mainInds =
          ctrler.main.sublist(0, currentDeclare.n).map((e) => e.t1).toList();
      break;
    case IndDeclarerEnum.custom:
      // TODO
      break;
    default:
  }

  for (var item in mainInds) {
  doc.addPage(
      pw.Page(
        pageFormat: format,
        theme: theme,
        build: (ctx) => pw.Column(children: [
          pw.Center(
              child: pw.Text(FunForOnePdfDeclarer.genStringFromExpression(
                  input: item, expression: currentDeclare.headerScript))),
        ]),
      ),
    );    
  }

  return doc.save();
}
