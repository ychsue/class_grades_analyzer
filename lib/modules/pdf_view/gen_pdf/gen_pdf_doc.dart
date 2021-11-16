import 'dart:typed_data';
import 'package:class_grades_analyzer/data/model/dimensions/tab_names.dart';
import 'package:class_grades_analyzer/data/model/pdf/main_pdf_declarer.dart';
import 'package:class_grades_analyzer/data/model/pdf/one_pdf_declarer.dart';
import 'package:class_grades_analyzer/modules/pdf_view/gen_pdf/gen_one_pdf_item.dart';
import 'functions/get_inds.dart';
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
  final List<dynamic> mainInds = getInds(
      indType: mainIndType,
      viewInds: ctrler.main,
      nStSelN: currentDeclare.nStSelN);

  final nPerPage = currentDeclare.nPerPage;
  List<pw.Widget> buf = [];
  Function addIntoPage = (List<pw.Widget> buf) {
    final buf1 = List.of(
        buf); // This line is necessary, or it will always output an empty one
    doc.addPage(pw.Page(
      pageFormat: format,
      theme: theme,
      build: (ctx) => pw.Column(
        children: [...buf1],
      ),
    ));
    buf.clear();
  };
  for (var i = 0; i < mainInds.length; i++) {
    final mainInd = mainInds[i];
    final ind = i + 1;
    buf.add(
      pw.Expanded(
        child: pw.Padding(
          padding: pw.EdgeInsets.all(8),
          child: pw.Column(
            children:
                genAMainPDFBundle(mainInd, currentDeclare, ctrler, format),
          ),
        ),
      ),
    );
    if (ind % nPerPage == 0) {
      addIntoPage(buf);
    }
  }
  if (buf.length != 0) {
    addIntoPage(buf);
  }

  return doc.save();
}

/// generate a list of PDFWidget items for each main declarer
///
List<pw.Widget> genAMainPDFBundle(
    dynamic mainInd,
    MainPdfDeclarerModel currentDeclare,
    PdfViewController ctrler,
    PdfPageFormat format) {
  return [
    // headerr
    pw.Center(
      child: pw.Text(
        FunForOnePdfDeclarer.genStringFromExpression(
            input: mainInd, expression: currentDeclare.headerScript),
        style: pw.TextStyle(fontSize: 14),
      ),
    ),
    ...List.generate(
      ctrler.currentDeclare.value.children.length,
      (ind) => pw.Expanded(
        child: genOnePdfItem(
            format, ctrler, mainInd, ctrler.currentDeclare.value.children[ind]),
      ),
    ),
    pw.Container(
      alignment: pw.Alignment.bottomLeft,
      margin: pw.EdgeInsets.all(12),
      child: pw.Text("${ctrler.currentDeclare.value.bottomScript}"),
    ),
    
  ];
}
