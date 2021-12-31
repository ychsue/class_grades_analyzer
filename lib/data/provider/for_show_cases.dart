import 'package:class_grades_analyzer/data/model/dimensions/each_case_model.dart';
import 'package:get_storage/get_storage.dart';

class ForShowCasesApi {
  static String storageName = "for_show_cases";
  static String mainKey = "cases";
  static GetStorage box = GetStorage(storageName);

  static initAsync() async {
    return await box.initStorage;
  }

  static List<EachCaseModel>? readCases() {
    final json = box.read(mainKey);

    final data = (json == null) ? null : List<Map<String, dynamic>>.from(json);
    if (data != null)
      return data.map((e) => EachCaseModel.fromJson(e)).toList();
    return null;
  }

  static writeCasesAsync(List<EachCaseModel> cases) async {
    final json = cases.map((e) => e.toJson()).toList();
    return await box.write(mainKey, json);
  }
}
