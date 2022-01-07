import 'package:class_grades_analyzer/controllers/exams_controller.dart';
import 'package:class_grades_analyzer/controllers/id_and_course_keys_controller.dart';
import 'package:class_grades_analyzer/controllers/my_global_controller.dart';
import 'package:class_grades_analyzer/data/provider/for_pdf_declarer.dart';
import 'package:class_grades_analyzer/data/provider/id_and_course_keys.dart';
import 'package:class_grades_analyzer/modules/dims/dims_controller.dart';
import 'package:class_grades_analyzer/modules/home/mytab_controller.dart';
import 'package:class_grades_analyzer/modules/doing_sth/doing_sth_controller.dart';
import 'package:class_grades_analyzer/my_test_widgets/main_test.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'routes/app_pages.dart';
import 'theme/app_theme_data.dart';

void main() async {
  if (true) {
    //foundation.kReleaseMode) {
    Get.put(MyGlobalController());
    final cIdAndCourseKeys = Get.put(IdAndCourseKeysController());
    Get.put(DoingSthController());
    Get.put(ExamsController());
    Get.put(MyTabController());
    Get.put(DimsController());

    await IdAndCourseKeysApi.initAsync();
    cIdAndCourseKeys.updateFromGetStorage();
    // await ForShowCasesApi.initAsync();
    // IOShowCases.loadFromStorage2MyGV();
    await ForPDFDeclarer.initAsync();

    runApp(GetMaterialApp(
      title: "導師成績分析工具", // I18N
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
