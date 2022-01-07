import 'dart:convert';

import 'package:class_grades_analyzer/data/model/pdf/main_pdf_declarer.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ForPDFDeclarer {
  static const String key = 'pdf-declarer';
  static GetStorage box = GetStorage(key);
  static RxInt initState = 0.obs; // 0: before, 1: -ing, 2: -ed
  static initAsync() async {
    if (initState.value >= 1) return;
    initState.value = 1;
    await box.initStorage;
    initState.value = 2;
  }

  static Future<List<MainPdfDeclarerModel>?> load() async {
    if (initState.value == 0) await initAsync();
    if (initState.value == 1)
      await initState.stream.firstWhere((element) => element == 2);
    final rareData = box.read(key);
    if (rareData == null) return null;

    final json = jsonDecode(rareData);
    final jmap = List<Map<String, dynamic>>.from(json);
    return jmap
        .map<MainPdfDeclarerModel>((e) => MainPdfDeclarerModel.fromJson(e))
        .toList();
  }

  static write(List<Rx<MainPdfDeclarerModel>> allMainPdfDeclares) async {
    final rareData = allMainPdfDeclares.map((e) => e.value.toJson()).toList();
    await box.write(key, jsonEncode(rareData));
  }
}
