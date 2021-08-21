import 'package:class_grades_analyzer/data/model/exams_model.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../data/model/id_keys_model.dart';
import '../data/model/course_keys_model.dart';
import 'package:collection/collection.dart';

class IdAndCourseKeysController extends GetxController {
  IdKeysModel ids = ["座號", "姓名"];
  CourseKeysModel courseKeys = {
    "數學": 100,
    "自然": 100,
    "社會": 100,
    "國文": 100,
    "英語": 100
  };

  List<Map<String, dynamic>> currentIds = [];
  List<String> currentCourseKeys = [];
  List<String> currentExamKeys = [];

  updateCurrentKeys(ExamsModel exams) {
    /// As described in [this StackOverflow](https://stackoverflow.com/questions/12030613/how-can-i-delete-duplicates-in-a-dart-list-list-distinct)
    /// I can use toSet=>toList to remove the duplicated one
    ///
    // currentExamKeys = exams.examNames.toSet().toList();
    Set<String> examKeyBuf = {};

    Set<Map<String, dynamic>> idsBuf = {};
    Set<String> courseKeyBuf = {};
    for (var exam in exams.exams) {
      examKeyBuf.add(exam.id);
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
    currentExamKeys = examKeyBuf.toList();
    currentIds = idsBuf.toList();
    currentCourseKeys = courseKeyBuf.toList();
  }
}
