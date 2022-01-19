import 'package:class_grades_analyzer/controllers/my_global_controller.dart';
import 'package:class_grades_analyzer/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DataGuard extends GetMiddleware {
  final gC = Get.find<MyGlobalController>();

  @override
  RouteSettings? redirect(String? route) {
    if (gC.hasData == true) {
      return null;
    } else {
      return RouteSettings(name: Routes.HOME);
    }
  }
}
