import 'package:class_grades_analyzer/modules/doing_sth/doing_sth.dart';
import 'package:class_grades_analyzer/modules/home_page.dart';
import 'package:get/get.dart';
part './app_routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.HOME,
      page: () => HomePage(),
    ),
    GetPage(
      name: Routes.DOINGSTH,
      page: () => DoingSth(),
      opaque: false,
    ),
  ];
}
