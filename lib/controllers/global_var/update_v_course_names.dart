import 'package:class_grades_analyzer/controllers/id_and_course_keys_controller.dart';
import 'package:class_grades_analyzer/controllers/my_global_controller.dart';
import 'package:class_grades_analyzer/data/model/one_exam_row_model.dart';
import 'package:get/get.dart';

void updateVCourseNames() {
  final gC = Get.find<MyGlobalController>();
  final idC = Get.find<IdAndCourseKeysController>();

  // 1. Update AvgName
  if (idC.avgName.value != VCourseNames.average) {
    final avgName = idC.avgName.value;
    final oldAvgName = VCourseNames.average;
    // 1.1 Update VCourseNames
    VCourseNames.average = avgName;
    // 1.2 Update PairModel in gC.allAxes
    final course = gC.allAxes.course;
    course.forEach((ele) {
      if (ele.t1 == oldAvgName) {
        ele.t1 = avgName;
      }
    });
    // 1.3 Update PairModel in gC.cases
    for (var myCase in gC.cases) {
      myCase.value.sortIndices.course.forEach((ele) {
        if (ele.t1 == oldAvgName) ele.t1 = avgName;
      });
    }
  }

  // 2. Update sumName
  if (idC.sumName.value != VCourseNames.sum) {
    final sumName = idC.sumName.value;
    final oldSumName = VCourseNames.sum;
    // 2.1 Update VCourseNames
    VCourseNames.sum = sumName;
    // 2.2 Update PairModel in gC.allAxes
    final course = gC.allAxes.course;
    course.forEach((ele) {
      if (ele.t1 == oldSumName) {
        ele.t1 = sumName;
      }
    });
    // 2.3 Update PairModel in gC.cases
    for (var myCase in gC.cases) {
      myCase.value.sortIndices.course.forEach((ele) {
        if (ele.t1 == oldSumName) ele.t1 = sumName;
      });
    }
  }
}
