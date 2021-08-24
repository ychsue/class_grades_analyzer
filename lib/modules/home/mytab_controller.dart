import 'dart:async';

import 'package:class_grades_analyzer/controllers/my_global_controller.dart';
import 'package:class_grades_analyzer/data/model/dimensions/tab_names.dart';
import 'package:class_grades_analyzer/data/model/exams_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart' as rxdart;

/// Used to control TabBar
/// Gotten from https://stackoverflow.com/questions/63924491/how-to-build-a-tabview-using-flutter-getx
///
class MyTabController extends GetxController with SingleGetTickerProviderMixin {
  final c = Get.find<MyGlobalController>();

  final _unsubscribe = StreamController<bool>.broadcast();

  /// Because the length of Tabs must be the same as of TabController
  /// They have to be loaded at the same time.
  /// Therefore, I combine them together
  ///
  late Rx<TabsNController> tNc = TabsNController(tabs: [
    Tab(
      icon: MyGlobalController.Tabs[TabNames.home],
      text: TabNames.home,
    )
  ], controller: null)
      .obs;

  @override
  void onInit() {
    super.onInit();
    _updateTab(null);
    c.exams.stream.takeUntil(_unsubscribe.stream).listen(_updateTab);
  }

  void _updateIndex() {
    var controller = tNc.value.controller;
    if (controller == null) return;
    c.tab.value = MyGlobalController.Tabs.keys.toList()[controller.index];
  }

  void _updateTab(ExamsModel? exams) {
    var keys = MyGlobalController.Tabs.keys.toList();
    var tabs = <Tab>[
      for (var i = 0; i < ((exams == null) ? 1 : keys.length); i++)
        Tab(
          text: keys[i],
          icon: MyGlobalController.Tabs[keys[i]],
        )
    ];
    tNc.value.tabs = tabs;

    tNc.value.controller?.removeListener(_updateIndex);
    tNc.value.controller = TabController(vsync: this, length: tabs.length);
    tNc.value.controller?.addListener(_updateIndex);
    if (tabs.length > 1) {
      () async {
        await Future.delayed(const Duration(microseconds: 0));
        tNc.value.controller?.index =
            1; //it should be done after myTabs is updated.
      }();
    }
  }

  @override
  void onClose() {
    _unsubscribe.add(true);
    _unsubscribe.close();
    tNc.value.controller?.removeListener(_updateIndex);
    tNc.value.controller?.dispose();
    super.onClose();
  }
}

class TabsNController {
  List<Tab> tabs;
  TabController? controller;
  TabsNController({required this.tabs, this.controller});
}
