import 'package:class_grades_analyzer/controllers/id_and_course_keys_controller.dart';
import 'package:class_grades_analyzer/data/model/one_exam_row_model.dart';
import 'package:class_grades_analyzer/data/model/one_record_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

void main() {
  group("One Exam Row Model tests", () {
    late var id;
    late var grades;
    setUp(() {
      id = {"座號": 10, "姓名": "abc"};
      grades = {
        "國文": OneRecordModel()..numb = 100,
        "英語": OneRecordModel()..numb = 80,
        "數學": OneRecordModel()..numb = 90,
        "自然": OneRecordModel()..numb = 100
      };
      Get.put(IdAndCourseKeysController());
    });
    test("sum", () {
      var theModel = OneExamRowModel(id: id, courses: grades);
      expect(theModel.sum(), 370);
    });
    test("average", () {
      var theModel = OneExamRowModel(id: id, courses: grades);
      expect(theModel.average(), 92.5);
    });
  });
}
