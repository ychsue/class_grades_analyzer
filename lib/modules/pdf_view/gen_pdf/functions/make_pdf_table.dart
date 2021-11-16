import 'package:class_grades_analyzer/utils/num2String.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'package:class_grades_analyzer/data/model/dimensions/tab_names.dart';

pw.Table makePdfTable(TabsEnum xFor, List<dynamic> xInds, TabsEnum yFor,
    List<dynamic> yInds, List<List<dynamic>> data) {
  final children = <pw.TableRow>[];

  pw.TableRow aRow;

  // 1st Row
  aRow = pw.TableRow(
      decoration: pw.BoxDecoration(color: PdfColors.yellow),
      children: [
        ...((yFor == TabsEnum.student)
            ? [for (var key in (yInds[0] as Map).keys) FirstRowText("$key")]
            : [FirstRowText(TabNames.name(yFor))]), // 還沒想好要插入甚麼, 可能數量不只一個
        for (var xInd in xInds) FirstRowText("${xInd.toString()}")
      ]);
  children.add(aRow);

  // data
  for (var i = 0; i < yInds.length; i++) {
    final yInd = yInds[i];
    aRow = pw.TableRow(children: [
      ...((yFor == TabsEnum.student)
          ? [for (var v in (yInds[i] as Map).values) CeilText("$v")]
          : [CeilText("${yInd.toString()}")]),
      // pw.Text("${yInd.toString()}"), // 測試中
      ...data[i].map((e) => CeilText("${num2String(e)}")),
    ]);
    children.add(aRow);
  }

  final outBorder = pw.BorderSide(width: 2);
  final vBorder = pw.BorderSide(width: 1);
  final hBorder = vBorder;
  final result = pw.Table(
      children: children,
      border: pw.TableBorder(
        bottom: outBorder,
        top: outBorder,
        left: outBorder,
        right: outBorder,
        verticalInside: vBorder,
        horizontalInside: hBorder,
      )
      // border: pw.TableBorder.all(
      //   color: PdfColors.lightBlueAccent,
      //   width: 2.0,
      // ),
      );
  return result;
}

// ignore: non_constant_identifier_names
pw.Widget FirstRowText(String text) {
  return pw.Padding(
    padding: pw.EdgeInsets.all(4.0),
    child: pw.Text(
      text,
      style: pw.TextStyle(fontBold: pw.Font.timesBold(), fontSize: 14),
    ),
  );
}

// ignore: non_constant_identifier_names
pw.Widget CeilText(String text) {
  return pw.Padding(
    padding: pw.EdgeInsets.all(4.0),
    child: pw.Text(
      text,
    ),
  );
}
