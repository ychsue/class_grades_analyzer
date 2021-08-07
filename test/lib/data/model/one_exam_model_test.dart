import 'dart:math';

import 'package:class_grades_analyzer/controllers/id_and_grade_keys_controller.dart';
import 'package:class_grades_analyzer/data/model/one_exam_model.dart';
import 'package:class_grades_analyzer/data/model/one_exam_row_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

void main() {
  group("One Exam Model tests", () {
    late OneExamModel oneExam;
    setUp(() {
      oneExam = OneExamModel(id: "102_1_1", students: [
        OneExamRowModel(
          id: {"座號": 1, "姓名": "abc"},
          data: {"國文": 80, "英語": 60.0, "數學": 100, "自然": 90},
        ),
        OneExamRowModel(
          id: {"座號": 2, "姓名": "def"},
          data: {"國文": 60, "英語": 100, "數學": 90, "自然": 80},
        ),
        OneExamRowModel(
          id: {"座號": 3, "姓名": "ghi"},
          data: {"國文": 100, "英語": 90, "數學": 80, "自然": 60},
        ),
        OneExamRowModel(
          id: {"座號": 4, "姓名": "jkl"},
          data: {"國文": 100, "英語": 80, "數學": 60, "自然": 100},
        ),
      ]);
      Get.put(IdAndGradeKeysController());
    });
    test("highest", () {
      var highest = oneExam.highest;
      var gWen = highest!["國文"];
      expect(gWen!.length, 2);
      expect(gWen[1], 3);
    });
    test("lowest", () {
      var lowest = oneExam.lowest;
      var gWen = lowest!["國文"];
      expect(gWen!.length, 1);
      expect(gWen[0], 1);
    });
    test("average", () {
      var avg = oneExam.averages!;
      expect(avg["國文"], closeTo(340 / 4.0, pow(10, -8)));
      expect(avg["數學"], closeTo(330 / 4.0, pow(10, -8)));
    });
    test("rank", () {
      var rank = oneExam.rank;
      expect(rank[3], 0);
    });
  });
}
