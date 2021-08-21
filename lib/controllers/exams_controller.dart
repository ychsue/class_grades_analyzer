import 'dart:async';

import 'package:class_grades_analyzer/controllers/my_global_controller.dart';
import 'package:class_grades_analyzer/data/model/exams_model.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

class ExamsController extends GetxController {
  /// IO [exams]
  var exams = (null as ExamsModel).obs;

  final gC = Get.find<MyGlobalController>();
  final _unsubscribed = StreamController<bool>.broadcast();

  @override
  void onInit() {
    exams.stream.takeUntil(_unsubscribed.stream).listen((exams) {
      updateCurrentKeys(exams);
      gC.exams.value = exams;
    });
    super.onInit();
  }

  @override
  void onClose() {
    _unsubscribed.add(true);
    _unsubscribed.close();
    super.onClose();
  }

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
    gC.currentExamKeys = examKeyBuf.toList();
    gC.currentIds = idsBuf.toList();
    gC.currentCourseKeys = courseKeyBuf.toList();
  }
}
