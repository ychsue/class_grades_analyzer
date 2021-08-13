import 'dart:math' as math;

import 'package:class_grades_analyzer/data/model/one_exam_model.dart';
import 'package:class_grades_analyzer/data/model/one_exam_row_model.dart';
import 'package:class_grades_analyzer/data/model/one_record_model.dart';
import 'package:class_grades_analyzer/data/provider/from_excel_file/one_exam/__get_key_columns.dart';

/// The rank based on the compaison for all students
/// per exam, per course, all students
///
void fillTheRanks(OneExamModel exam, ICKeys icKeys) {
  List<OneRecordModel?> forSort;
  for (var courseKey in icKeys.courseKeyC.keys) {
    // 1. find the set of each course
    forSort = List.of(exam.students.map((e) => e.courses[courseKey]).toList());
    _provideRank4Courses(forSort);
  }

  // 2. sort virtual course sum
  forSort = List.of(exam.students.map((e) => e.vCourses.sum));
  _provideRank4Courses(forSort);

  // 3. sort virtual course average
  forSort = List.of(exam.students.map((e) => e.vCourses.average));
  _provideRank4Courses(forSort);
}

void _provideRank4Courses(List<OneRecordModel?> forSort) {
  forSort.sort(
      (a, b) => ((b?.numb ?? (-100)) * 10 - (a?.numb ?? (-100)) * 10).floor());
  // 2. find the rank
  int rank = 1;
  for (var i = 0; i < forSort.length; i++) {
    if (i != 0 && forSort[i - 1]?.numb != forSort[i]?.numb) {
      rank++;
    }
    forSort[i]?.rank = rank;
  }
}
