import 'package:class_grades_analyzer/controllers/id_and_grade_keys_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'routes/app_pages.dart';
import 'theme/app_theme_data.dart';

void main() {
  Get.put(IdAndGradeKeysController());
  
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: Routes.HOME,
    theme: appThemeData,
    defaultTransition: Transition.fade,
    // initialBinding: SplashBinding(),
    getPages: AppPages.pages,
    // home: SplashPage(),
  ));
}
