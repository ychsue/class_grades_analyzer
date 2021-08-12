import 'package:class_grades_analyzer/controllers/id_and_grade_keys_controller.dart';
import 'package:class_grades_analyzer/modules/doing_sth/doing_sth_controller.dart';
import 'package:class_grades_analyzer/my_test_widgets/main_test.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'routes/app_pages.dart';
import 'theme/app_theme_data.dart';

void main() {
  if (true) {
    //foundation.kReleaseMode) {
    Get.put(IdAndGradeKeysController());
    Get.put(DoingSthController());

    runApp(GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.HOME,
      theme: appThemeData,
      defaultTransition: Transition.fade,
      // initialBinding: SplashBinding(),
      getPages: AppPages.pages,
      // home: SplashPage(),
    ));
  } else {
    mainTest();
  }
}
