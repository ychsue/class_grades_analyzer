import 'package:class_grades_analyzer/modules/doing_sth/doing_sth.dart';
import 'package:class_grades_analyzer/routes/app_pages.dart';
import 'package:get/get.dart';

class DoingSthController extends GetxController {
  final from = 0.0.obs;
  final previousProgress = 0.0.obs; // Changed per _duration when doing == true
  final progress = 0.0.obs; // Changed per _duration when doing == true
  static const _duration = Duration(seconds: 1);
  final to = 0.0.obs;
  final doing = false.obs;

  static const _defaultTitle = "In Progress"; //I18N
  final title = _defaultTitle.obs;

  DoingSthController() {
    doing.listen((v) async {
      if (v == true) {
        progress.value = from.value; // initialize the progress to "from"
        do {
          previousProgress.value = progress.value;
          progress.value = (progress.value + to.value) / 2.0;
          await Future.delayed(_duration);
        } while (doing.value == true);
      }
    });
  }

  void start(
    double? start,
    double? end,
  ) {
    if (start != null) from.value = start;
    if (end != null) to.value = end;
    if (start != null && end != null && end > start) {
      previousProgress.value = progress.value;
      progress.value = start;
      final page = DoingSth();
      if (Get.currentRoute.contains(page.runtimeType.toString()) == false)
        Get.to(page);
      doing.value = true;
    }
  }

  void done() {
    doing.value = false;
    progress.value = to.value;
    title.value = _defaultTitle;
    Get.back();
  }
}
