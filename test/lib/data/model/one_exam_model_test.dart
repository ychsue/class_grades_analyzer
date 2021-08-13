import 'dart:math';

import 'package:class_grades_analyzer/controllers/id_and_course_keys_controller.dart';
import 'package:class_grades_analyzer/data/model/one_exam_model.dart';
import 'package:class_grades_analyzer/data/model/one_exam_row_model.dart';
import 'package:class_grades_analyzer/data/model/one_record_model.dart';
import 'package:class_grades_analyzer/data/model/extensions/virtual_courses.dart';
import 'package:class_grades_analyzer/data/provider/from_excel_file/one_exam/__fill_the_ranks.dart';
import 'package:class_grades_analyzer/data/provider/from_excel_file/one_exam/__get_key_columns.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

void main() {
  group("One Exam Model tests", () {
    late OneExamModel oneExam;
    final ICKeys icKeys = ICKeys();
    setUp(() {
      oneExam = OneExamModel(id: "102_1_1", students: [
        OneExamRowModel(
          id: {"座號": 1, "姓名": "abc"},
          courses: {
            "國文": OneRecordModel()..numb = 80,
            "英語": OneRecordModel()..numb = 60.0,
            "數學": OneRecordModel()..numb = 100,
            "自然": OneRecordModel()..numb = 90
          },
        ),
        OneExamRowModel(
          id: {"座號": 2, "姓名": "def"},
          courses: {
            "國文": OneRecordModel()..numb = 60,
            "英語": OneRecordModel()..numb = 100,
            "數學": OneRecordModel()..numb = 90,
            "自然": OneRecordModel()..numb = 70
          },
        ),
        OneExamRowModel(
          id: {"座號": 3, "姓名": "ghi"},
          courses: {
            "國文": OneRecordModel()..numb = 100,
            "英語": OneRecordModel()..numb = 90,
            "數學": OneRecordModel()..numb = 80,
            "自然": OneRecordModel()..numb = 80
          },
        ),
        OneExamRowModel(
          id: {"座號": 4, "姓名": "jkl"},
          courses: {
            "國文": OneRecordModel()..numb = 100,
            "英語": OneRecordModel()..numb = 80,
            "數學": OneRecordModel()..numb = 90,
            "自然": OneRecordModel()..numb = 100
          },
        ),
      ]);
      final c = IdAndCourseKeysController();
      Get.put(c);
      icKeys..courseKeyC = c.courseKeys;
    });
    test("sum", () {
      var sum = oneExam.students[0].sum();
      expect(sum, 80 + 60 + 90 + 100);
    });
    test("average", () {
      var average = oneExam.students[1].average();
      expect(average, (70.0 + 60 + 90 + 100) / 4.0);
    });

    test("rank", () {
      fillTheRanks(oneExam, icKeys);
      expect(oneExam.students[0].vCourses.average?.rank, 3);
    });
  });
}
