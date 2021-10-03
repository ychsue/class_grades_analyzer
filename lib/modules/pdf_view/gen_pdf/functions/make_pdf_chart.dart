import 'dart:math';

import 'package:class_grades_analyzer/data/model/dimensions/tab_names.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

pw.Chart makePdfChart(TabsEnum xFor, List<dynamic> xInds, TabsEnum yFor,
    List<dynamic> yInds, List<List<dynamic>> data) {
  final List<num> yGrid = getYGrid(data, 4);

  final result = pw.Chart(
      right: pw.ChartLegend(),
      grid: pw.CartesianGrid(
        xAxis: pw.FixedAxis.fromStrings(
            [for (var xInd in xInds) "${xInd.toString()}"]),
        yAxis: pw.FixedAxis(
          yGrid,
          divisions: true,
        ),
      ),
      datasets: [
        for (var i = 0; i < yInds.length; i++)
          genOneLineDataSet(yInds[i], data[i])
      ]);
  return result;
}

pw.LineDataSet genOneLineDataSet(yInd, List data) {
  final result = pw.LineDataSet(
      legend: "${yInd.toString()}",
      color: randRGB(),
      data: List<pw.LineChartValue>.generate(
        data.length,
        (i) {
          final numb = (data[i] is num)
              ? data[i]
              : ((data[i] is String) ? double.tryParse(data[i]) : null);
          return pw.LineChartValue(i.toDouble(), numb ?? double.nan);
        },
      ));

  return result;
}

PdfColor randRGB() {
  final randN = () => Random().nextDouble();
  return PdfColor(randN(), randN(), randN());
}

List<num> getYGrid(List<List> data, int nGrid) {
  final List<num> result = [];
  const int MAX = 10000000000;
  num imax = -MAX, imin = MAX;
  // 1. find the max and min
  for (var iy in data) {
    for (var ix in iy) {
      final numb =
          (ix is num) ? ix : ((ix is String) ? num.tryParse(ix) : null);
      if (numb != null) {
        imax = (numb > imax) ? numb : imax;
        imin = (numb < imin) ? numb : imin;
      }
    }
  }

  if (imax == -MAX) return result;
  final dValue = (imax - imin) / (nGrid - 1);
  // 2. get the grid
  for (var i = 0; i < nGrid; i++) {
    if (i == 0) {
      result.add(imin);
      continue;
    } else if (i == (nGrid - 1)) {
      result.add(imax);
    } else {
      final value = (dValue * i + imin).floor();
      if (value != result.last) {
        result.add(value);
      }
    }
  }

  return result;
}
