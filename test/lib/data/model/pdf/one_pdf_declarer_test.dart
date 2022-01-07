import 'dart:convert';

import 'package:class_grades_analyzer/data/model/pdf/one_pdf_declarer.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_storage/get_storage.dart';

void main() {
  group('Test OnePdfDeclarerModel', () {
    late OnePdfDeclarerModel data;
    late GetStorage box;
    String key = "data";

    setUp(() async {
      data = OnePdfDeclarerModel();
      data.stSelX = "2~5";
      box = GetStorage();
      await box.initStorage;
    });

    test('toJson', () {
      final json = data.toJson();
      print(jsonEncode(json));
    });

    test('toJson and then save to GetStorage', () {
      box.write(
        key,
        jsonEncode(data.toJson()),
      );
      final output = box.read(key);
      print(output);
      final parsedOutput = jsonDecode(output);
      expect(parsedOutput['exchangeXY'], data.exchangeXY);
      expect(parsedOutput['xType'], data.xType.toString());
      expect(parsedOutput['stSelX'], data.stSelX);
      expect(parsedOutput['yType'], data.yType.toString());
      expect(parsedOutput['stSelY'], data.stSelY);
      expect(parsedOutput['type'], data.type.toString());
      expect(parsedOutput['gType'], data.gType.toString());
    });

    test('fromJson from GetStorage', () {
      box.write(
        key,
        jsonEncode(data.toJson()),
      );
      final output = box.read(key);
      print(output);
      final parsedOutput = jsonDecode(output);
      final result = OnePdfDeclarerModel.fromJson(parsedOutput);
      expect(result.exchangeXY, data.exchangeXY);
      expect(result.xType, data.xType);
      expect(result.stSelX, data.stSelX);
      expect(result.yType, data.yType);
      expect(result.stSelY, data.stSelY);
      expect(result.type, data.type);
      expect(result.gType, data.gType);
    });
  });
}
