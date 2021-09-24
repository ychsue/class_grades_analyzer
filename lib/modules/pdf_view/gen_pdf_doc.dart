import 'dart:typed_data';
import 'package:class_grades_analyzer/controllers/my_global_controller.dart';
import 'package:class_grades_analyzer/data/model/dimensions/tab_names.dart';
import 'package:class_grades_analyzer/data/model/pdf/main_pdf_declarer.dart';
import 'package:class_grades_analyzer/modules/pdf_view/pdf_view_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:pdf/src/widgets/font.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

Future<Uint8List> genPdfDoc(PdfPageFormat format, PdfViewController ctrler,
    [bool isOkay2Draw = false]) async {
  late TtfFont ttf;
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

  doc.addPage(
    pw.Page(
      pageFormat: format,
      theme: theme,
      build: (ctx) => pw.Center(child: pw.Text("Hello")),
    ),
  );

  return doc.save();
}
