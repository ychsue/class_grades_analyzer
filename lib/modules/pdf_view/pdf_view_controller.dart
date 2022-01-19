import 'package:class_grades_analyzer/controllers/my_global_controller.dart';
import 'package:class_grades_analyzer/data/model/dimensions/each_case_model.dart';
import 'package:class_grades_analyzer/data/model/pair.dart';
import 'package:class_grades_analyzer/data/model/pdf/main_pdf_declarer.dart';
import 'package:get/get.dart';

class PdfViewController extends GetxController {
  late Rx<MainPdfDeclarerModel> currentDeclare;
  late MyGlobalController gC;
  late Rx<EachCaseModel> axes;
  late List<PairModel<dynamic, bool>> main;
  late List<PairModel<dynamic, bool>> x;
  late List<PairModel<dynamic, bool>> y;
  final isOkay2Draw = false.obs;

  @override
  void onInit() {
    gC = Get.find<MyGlobalController>();
    axes = gC.cases.firstWhere((ele) => ele.value.main == gC.tab.value);
    main = axes.value.sortIndices.getDimByEnum(axes.value.main) ??
        axes.value.sortIndices.exam;
    x = axes.value.sortIndices.getDimByEnum(axes.value.x) ??
        axes.value.sortIndices.course;
    y = axes.value.sortIndices.getDimByEnum(axes.value.y) ??
        axes.value.sortIndices.student;

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
