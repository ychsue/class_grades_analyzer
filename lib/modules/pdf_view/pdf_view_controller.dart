import 'package:class_grades_analyzer/controllers/my_global_controller.dart';
import 'package:class_grades_analyzer/data/model/pdf/main_pdf_declarer.dart';
import 'package:get/get.dart';

class PdfViewController extends GetxController {
  late Rx<MainPdfDeclarerModel> currentDeclare;
  late MyGlobalController gC;

  @override
  void onInit() {
    gC = Get.find<MyGlobalController>();
    currentDeclare = gC.allMainPdfDeclares
        .firstWhere((ele) => ele.value.main == gC.tab.value);
    super.onInit();
  }
}

class PdfViewBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PdfViewController>(() => PdfViewController());
  }
}
