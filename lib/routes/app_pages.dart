import 'package:class_grades_analyzer/modules/doing_sth/doing_sth.dart';
import 'package:class_grades_analyzer/modules/home/home_page.dart';
import 'package:class_grades_analyzer/modules/pdf_view/pdf_view_controller.dart';
import 'package:class_grades_analyzer/modules/pdf_view/pdf_view_page.dart';
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
    GetPage(
      name: Routes.PDFVIEW,
      page: () => PdfViewPage(),
      binding: PdfViewBinding(),
    ),
  ];
}
