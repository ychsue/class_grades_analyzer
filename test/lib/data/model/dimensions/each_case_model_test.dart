import 'package:class_grades_analyzer/data/model/dimensions/each_case_model.dart';
import 'package:class_grades_analyzer/data/model/dimensions/tab_names.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_storage/get_storage.dart';

void main() {
  group("Test toJson", () {
    late EachCaseModel aCase;
    late Map<String, dynamic> json;
    setUp(() {
      aCase = EachCaseModel(
        main: TabsEnum.student,
        x: TabsEnum.course,
        y: TabsEnum.exam,
      );
      json = aCase.toJson();
    });
    test("toJson check", () {
      expect(json["main"], TabNames.name(TabsEnum.student));
      expect(json["sortIndices"], aCase.sortIndices.toJson());
    });
    test("toJson: write into GetStorage", () {
      var box = GetStorage();
      box.write("EachCaseModel", json);
      var data = box.read("EachCaseModel");
      expect(data["main"], TabNames.name(TabsEnum.student));
      expect(data["sortIndices"], aCase.sortIndices.toJson());
    });
  });
  group("Test fromJson", () {
    late EachCaseModel aCase;
    late Map<String, dynamic> json;
    setUp(() {
      aCase = EachCaseModel(
        main: TabsEnum.student,
        x: TabsEnum.course,
        y: TabsEnum.exam,
      );
      json = aCase.toJson();
    });
    test("fromJson", () {
      var data = EachCaseModel.fromJson(json);
      expect(aCase.main, TabsEnum.student);
      expect(data.sortIndices.student[0].t1, aCase.sortIndices.student[0].t1);
    });
  });
}
