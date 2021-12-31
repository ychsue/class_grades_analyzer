import 'package:class_grades_analyzer/controllers/my_global_controller.dart';
import 'package:class_grades_analyzer/data/provider/for_show_cases.dart';
import 'package:get/get.dart';

class IOShowCases {
  static saveToStorageAsync() async {
    final gc = Get.find<MyGlobalController>();
    final cases = gc.cases;
    final listOfCases = cases.map((e) => e.value).toList();
    await ForShowCasesApi.writeCasesAsync(listOfCases);
  }

  static loadFromStorage2MyGV() {
    final data = ForShowCasesApi.readCases();
    if (data != null) {
      final gc = Get.find<MyGlobalController>();
      final cases = gc.cases;
      data.forEach((e1) {
        cases
            .firstWhere(
              (e2) => e2.value.main == e1.main,
              orElse: () => cases.first,
            )
            .value = e1;
      });
    }
    return data;
  }
}
