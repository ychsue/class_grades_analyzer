import 'package:class_grades_analyzer/data/model/dimensions/tab_names.dart';
import 'package:pdf/widgets.dart' as pw;

pw.Table makePdfTable(TabsEnum xFor, List<dynamic> xInds, TabsEnum yFor,
    List<dynamic> yInds, List<List<dynamic>> data) {
  final children = <pw.TableRow>[];

  pw.TableRow aRow;

  // 1st Row
  aRow = pw.TableRow(children: [
    ...((yFor == TabsEnum.student)
        ? [for (var key in (yInds[0] as Map).keys) pw.Text("$key")]
        : [pw.Text(TabNames.name(yFor))]), // 還沒想好要插入甚麼, 可能數量不只一個
    for (var xInd in xInds) pw.Text("${xInd.toString()}")
  ]);
  children.add(aRow);

  // data
  for (var i = 0; i < yInds.length; i++) {
    final yInd = yInds[i];
    aRow = pw.TableRow(children: [
      ...((yFor == TabsEnum.student)
          ? [for (var v in (yInds[i] as Map).values) pw.Text("$v")]
          : [pw.Text("${yInd.toString()}")]),
      // pw.Text("${yInd.toString()}"), // 測試中
      ...data[i].map((e) => pw.Text("${e.toString()}")),
    ]);
    children.add(aRow);
  }

  final result = pw.Table(children: children);
  return result;
}
