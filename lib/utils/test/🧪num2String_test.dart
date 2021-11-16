import 'package:class_grades_analyzer/utils/num2String.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('test input is null', () {
    final a = null;
    expect(num2String(a), 'null');
  });
  test('test input is 12.3 & 12.34567', () {
    final a = 12.3;
    final b = 12.34567;
    expect(num2String(a), '12.3');
    expect(num2String(b), '12.34');
  });
  test('test input decimalDigit', () {
    final a = 12.34567;
    expect(num2String(a, 3), '12.345');
  });
}
