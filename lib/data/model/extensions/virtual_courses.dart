import 'package:class_grades_analyzer/controllers/id_and_course_keys_controller.dart';
import 'package:get/get.dart';

import '../one_exam_row_model.dart';

extension VirtualCourses on OneExamRowModel {
  num sum() {
    return courses.values
            .map((v) => v.numb)
            .reduce((value, element) => (value ?? 0) + (element ?? 0)) ??
        0;
  }

  // #region average
  num average() {
    var c = Get.find<IdAndCourseKeysController>();
    var sumW = 0;
    var sum = 0.0;

    courses.forEach((key, value) {
      var w = c.courseKeys[key] ?? 0;
      sumW += w;
      sum += w * (value.numb ?? 0);
    });
    return sum / sumW;
  }
  // #endregion average
}
