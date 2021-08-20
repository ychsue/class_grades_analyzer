import 'dart:async';

import 'package:class_grades_analyzer/controllers/exam_controller.dart';
import 'package:class_grades_analyzer/data/model/exams_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Used to control TabBar
/// Gotten from https://stackoverflow.com/questions/63924491/how-to-build-a-tabview-using-flutter-getx
///
class MyTabController extends GetxController with SingleGetTickerProviderMixin {
  final c = Get.find<ExamController>();

  late StreamSubscription<ExamsModel?> _examListener;

  /// Because the length of Tabs must be the same as of TabController
  /// They have to be loaded at the same time.
  /// Therefore, I combine them together
  ///
  Rx<TabsNController> tNc = TabsNController(
          tabs: [Tab(icon: Icon(Icons.home))],
          controller: null as TabController)
      .obs;
  // RxList<Tab> myTabs = [Tab(icon: Icon(Icons.home))].obs;
  // Rx<TabController> controller = (null as TabController).obs;

  @override
  void onInit() {
    super.onInit();
    _updateAll(null);
    _examListener = c.exams.listen(_updateAll);
  }

  void _updateAll(ExamsModel? exams) {
    var tabs = <Tab>[
      Tab(icon: Icon(Icons.home)),
      ...((exams == null)
          ? []
          : [
              Tab(icon: Icon(Icons.description)),
              Tab(icon: Icon(Icons.person)),
              Tab(icon: Icon(Icons.library_books)),
            ]),
    ];
    tNc.value.tabs = tabs;
    tNc.value.controller = TabController(vsync: this, length: tabs.length);
  }

  @override
  void onClose() {
    _examListener.cancel();
    tNc.value.controller.dispose();
    super.onClose();
  }
}

class TabsNController {
  List<Tab> tabs;
  TabController controller;
  TabsNController({required this.tabs, required this.controller});
}
