import 'package:class_grades_analyzer/controllers/exams_controller.dart';
import 'package:class_grades_analyzer/data/model/dimensions/tab_names.dart';
import 'package:class_grades_analyzer/data/model/exams_model.dart';
import 'package:class_grades_analyzer/data/model/pair.dart';
import 'package:flutter/foundation.dart';

extension UpdateGlobalAxes on ExamsController {
  updateAxesIndices(ExamsModel exams) {
    /// As described in [this StackOverflow](https://stackoverflow.com/questions/12030613/how-can-i-delete-duplicates-in-a-dart-list-list-distinct)
    /// I can use toSet=>toList to remove the duplicated one
    ///
    // currentExamKeys = exams.examNames.toSet().toList();
    Set<String> examKeyBuf = {};

    Set<Map<String, dynamic>> idsBuf = {};
    Set<String> courseKeyBuf = {};
    for (var exam in exams.exams) {
      examKeyBuf.add(exam.name);
      var shouldGetCourseKey = true;
      for (var student in exam.students) {
        if (idsBuf.where((ele) => mapEquals(ele, student.id)).length == 0) {
          idsBuf.add(student.id);
        }
        if (shouldGetCourseKey) {
          courseKeyBuf.addAll(student.courses.keys);
          //Just take the first one
          shouldGetCourseKey = false;
        }
      }
    }
    gC.allAxes.exam =
        examKeyBuf.map((e) => PairModel<String, bool>(e, true)).toList();
    gC.allAxes.student = idsBuf
        .map((e) => PairModel<Map<String, dynamic>, bool>(e, true))
        .toList();
    gC.allAxes.course =
        courseKeyBuf.map((e) => PairModel<String, bool>(e, true)).toList();

    // Now I need to update cases
    for (var myCase in gC.cases) {
      myCase.value.sortIndices.exam =
          gC.allAxes.exam.map((e) => PairModel.of(e)).toList();
      myCase.value.toSelAll(axisEnum: TabsEnum.exam);
      myCase.value.sortIndices.student =
          gC.allAxes.student.map((e) => PairModel.of(e)).toList();
      myCase.value.toSelAll(axisEnum: TabsEnum.student);
      myCase.value.sortIndices.course =
          gC.allAxes.course.map((e) => PairModel.of(e)).toList();
      myCase.value.toSelAll(axisEnum: TabsEnum.course);
      myCase.refresh();
    }
  }
}
