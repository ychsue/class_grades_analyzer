import 'dart:async';

import 'package:class_grades_analyzer/controllers/my_global_controller.dart';
import 'package:class_grades_analyzer/data/model/exams_model.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';
import 'exams/update_global_axes.dart';
export 'exams/update_global_axes.dart';

class ExamsController extends GetxController {
  /// IO [exams]
  var exams = (null as ExamsModel).obs;

  final gC = Get.find<MyGlobalController>();
  final _unsubscribed = StreamController<bool>.broadcast();

  @override
  void onInit() {
    exams.stream.takeUntil(_unsubscribed.stream).listen((exams) {
      updateAxesIndices(exams);
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
}
