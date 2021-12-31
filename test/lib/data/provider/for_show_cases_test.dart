import 'dart:convert';

import 'package:class_grades_analyzer/data/model/dimensions/each_case_model.dart';
import 'package:class_grades_analyzer/data/model/dimensions/tab_names.dart';
import 'package:class_grades_analyzer/data/provider/for_show_cases.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_storage/get_storage.dart';

void main() {
  late List<EachCaseModel> testCases;
  setUpAll(() async {
    await ForShowCasesApi.initAsync();
  });
  test("read from null", () {
    final cases = ForShowCasesApi.readCases();
    expect(cases, null);
  });
  test("write and then read it", () async {
    final input = [
      EachCaseModel(
        main: TabsEnum.student,
        x: TabsEnum.course,
        y: TabsEnum.exam,
      ),
      EachCaseModel(
        main: TabsEnum.exam,
        x: TabsEnum.course,
        y: TabsEnum.student,
      ),
      EachCaseModel(
        main: TabsEnum.course,
        x: TabsEnum.student,
        y: TabsEnum.exam,
      ),
    ];
    await ForShowCasesApi.writeCasesAsync(input);
    final cases = ForShowCasesApi.readCases();
    expect(cases?.length, input.length);
    expect(cases?[0].sortIndices.student[0].t1,
        input[0].sortIndices.student[0].t1);
  });
}
