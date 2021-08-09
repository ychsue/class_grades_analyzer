import 'package:class_grades_analyzer/modules/doing_sth/doing_sth_controller.dart';
import 'package:class_grades_analyzer/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'doing_sth_test.dart';

void mainTest() {
  Get.put(DoingSthController());
  runApp(GetMaterialApp(
    home: TestHome(),
    getPages: AppPages.pages,
  ));
}
