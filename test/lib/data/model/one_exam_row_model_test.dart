import 'package:class_grades_analyzer/controllers/id_and_grade_keys_controller.dart';
import 'package:class_grades_analyzer/data/model/one_exam_row_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

void main() {
  group("One Exam Row Model tests", () {
    late var id;
    late var grades;
    setUp(() {
      id = {"座號": 10, "姓名": "abc"};
      grades = {"國文": 80, "英語": 60.0, "數學": 100, "化學": 90};
      Get.put(IdAndGradeKeysController());
    });
    test("sum", () {
      var theModel = OneExamRowModel(id: id, data: grades);
      expect(theModel.total, 330);
    });
    test("average", () {
      var theModel = OneExamRowModel(id: id, data: grades);
      expect(theModel.average, 80);
    });
  });
}
