import 'package:class_grades_analyzer/modules/doing_sth/doing_sth.dart';
import 'package:class_grades_analyzer/routes/app_pages.dart';
import 'package:flutter/animation.dart';
import 'package:get/get.dart';

/// For DoingSth widget, call [init] at first,
/// and call [clearAnimation] at its [dispose] function
/// then for others, call [start] to start and call [done] to end
class DoingSthController extends GetxController {
  var from = 0.0;
  var previousProgress = 0.0; // Changed per _duration when doing == true
  final progress = 0.0.obs; // Changed per _duration when doing == true
  static const _duration = Duration(seconds: 1);
  var to = 0.0;
  final doing = false.obs;

  static const _defaultTitle = "In Progress"; //I18N
  final title = _defaultTitle.obs;

  Rx<Animation<double>?>? _animation;
  Animation<double>? get animation => _animation?.value;
  AnimationController? _ctrler;
  void Function()? _setState;

  DoingSthController() {
    doing.listen((v) async {
      if (v == true && _ctrler != null && _setState != null) {
        do {
          _ctrler?.reset();
          _animation = (Tween(
            begin: previousProgress,
            end: progress.value,
          ).animate(_ctrler!)
                ..addListener(_setState!))
              .obs;
          _ctrler?.forward();
          previousProgress = progress.value;
          progress.value = (progress.value + to) / 2.0;
          await Future.delayed(_duration);
        } while (doing.value == true);
      }
    });
  }

  void init(
      {required AnimationController ctrler,
      required void Function(void Function()) setState}) {
    _ctrler = ctrler;
    animation?.removeListener(_setState!);
    _setState = () => setState(() {});
    doing.value = true;
  }

  void clearAnimation() {
    _ctrler?.dispose();
    _setState = null;
    _animation?.value = null;
  }

  void start(
    double? start,
    double? end,
  ) {
    if (start != null) from = start;
    if (end != null) to = end;
    if (start != null && end != null && end > start) {
      previousProgress = (animation?.value != null) ? animation!.value : start;
      progress.value = (previousProgress + end) / 2.0;
      final page = DoingSth();
      if (Get.currentRoute.indexOf(page.runtimeType.toString()) != 1)
        Get.to(page);
      if (_ctrler != null && _setState != null) doing.value = true;
    }
  }

  void done() {
    doing.value = false;
    progress.value = to;
    title.value = _defaultTitle;
    Get.back();
  }
}
