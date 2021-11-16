import 'package:class_grades_analyzer/data/model/one_exam_row_model.dart';
import 'package:class_grades_analyzer/data/model/one_record_model.dart';

import 'one_exam_model.dart';

class VStudentModel {
  final OneExamModel parent;
  bool isInitialzed = false;

  OneExamRowModel? _highest;
  OneExamRowModel? get highest => _highest;

  OneExamRowModel? _lowest;
  OneExamRowModel? get lowest => _lowest;

  OneExamRowModel? _average;
  OneExamRowModel? get average => _average;

  static const MAX = 1000000000;

  VStudentModel({required this.parent});

  initialize() {
    final students = parent.students;
    final nStudent = students.length;
    if (nStudent == 0) return;
    final cKeys = students[0].courses.keys;

    Map<String, num?> hCourses = {}; //highest
    Map<String, num?> lCourses = {}; //lowest
    Map<String, num?> aCourses = {}; //average

    for (var key in cKeys) {
      num hNumb = -MAX;
      num lNumb = MAX;
      num sum = 0;
      num nEfficient = 0;
      for (var st in students) {
        final numb = st.courses[key]?.numb;
        // 1.1 get highest value for each course
        if (numb != null && numb > hNumb) hNumb = numb;
        // 1.2 get lowest value for each course
        if (numb != null && numb < lNumb) lNumb = numb;
        // 1.3 get sum value for average for each course
        if (numb != null) {
          sum += numb;
          nEfficient += 1;
        }
      }
      // 2.1 output the highest value of this course
      hCourses.addEntries([MapEntry(key, (hNumb == -MAX) ? null : hNumb)]);
      // 2.2 output the lowest value of this course
      lCourses.addEntries([MapEntry(key, (lNumb == MAX) ? null : lNumb)]);
      // 2.3 output the average value of this course
      aCourses.addEntries(
          [MapEntry(key, (nEfficient == 0) ? null : sum / nEfficient)]);
    }

    // 3.1 Output to _highest
    _highest = OneExamRowModel(
      id: {VStudentKeys.highest: null},
      courses: hCourses.map(
        (key, value) => MapEntry(key, OneRecordModel()..numb = value),
      ),
    );
    // 3.2 Output to _lowest
    _lowest = OneExamRowModel(
      id: {VStudentKeys.lowest: null},
      courses: lCourses.map(
        (key, value) => MapEntry(key, OneRecordModel()..numb = value),
      ),
    );
    // 3.3 Output to _average
    _average = OneExamRowModel(
      id: {VStudentKeys.average: null},
      courses: aCourses.map(
        (key, value) => MapEntry(key, OneRecordModel()..numb = value),
      ),
    );

    isInitialzed = true;
  }
}

abstract class VStudentKeys {
  static const highest = "highest";
  static const lowest = "lowest";
  static const average = "average";
}
