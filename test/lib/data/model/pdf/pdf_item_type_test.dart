import 'package:class_grades_analyzer/data/model/pdf/pdf_item_type.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('toString', () {
    final input = PdfItemTypeEnum.lineChart;
    final stInput = input.toString();
    // final stInput = input.value;
    print(stInput);
    expect(stInput, 'PdfItemTypeEnum.lineChart');
  });

  test('fromString', () {
    final stInput = 'lineChart';
    final result = PdfItemTypeEnumExtension.fromString(stInput);
    print(result.toString());
    expect(result, PdfItemTypeEnum.lineChart);
  });
}
