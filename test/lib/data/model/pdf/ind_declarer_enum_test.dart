import 'package:class_grades_analyzer/data/model/pdf/ind_declare_enum.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("toString", () {
    final input = IndDeclarerEnum.selN;
    final stInput = input.toString();
    expect(stInput, 'IndDeclarerEnum.selN');
  });

  test('fromString', () {
    final input = 'selN';
    final result = IndDeclarerEnumExtension.fromString(input);
    print(result.toString());
    expect(result, IndDeclarerEnum.selN);
  });
}
