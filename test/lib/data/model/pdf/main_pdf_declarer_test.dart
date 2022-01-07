import 'dart:convert';

import 'package:class_grades_analyzer/data/model/dimensions/tab_names.dart';
import 'package:class_grades_analyzer/data/model/pdf/main_pdf_declarer.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_storage/get_storage.dart';

void main() {
  late MainPdfDeclarerModel data;
  late GetStorage box;
  final key = 'key';

  setUp(() async {
    data = MainPdfDeclarerModel(main: TabsEnum.exam);
    box = GetStorage();
    await box.initStorage;
  });

  test('toJson', () {
    final json = data.toJson();
    print(jsonEncode(json));
  });

  test('fromJson', () {
    box.write(key, jsonEncode(data.toJson()));
    final json = jsonDecode(box.read(key));
    final fData = MainPdfDeclarerModel.fromJson(json);
    expect(data.main, fData.main);
    expect(data.indType, fData.indType);
    expect(data.stSelN, fData.stSelN);
    expect(data.nPerPage, fData.nPerPage);
    expect(data.children[0].gType, fData.children[0].gType);
    expect(data.headerScript, fData.headerScript);
    expect(data.bottomScript, fData.bottomScript);
  });

  test("box with wrong key", () {
    final nothing = box.read('nothing');
    print(jsonEncode(nothing));
    expect(nothing, null);
  });
}
