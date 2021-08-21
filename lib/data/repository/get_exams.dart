import 'dart:convert';

import 'package:class_grades_analyzer/controllers/id_and_course_keys_controller.dart';
import 'package:class_grades_analyzer/data/model/exams_model.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../provider/from_excel_file/index.dart';
import 'package:flutter/foundation.dart';

class GetExamsRepository {
  final FromExcelFileApi api;

  GetExamsRepository(this.api);

  Future<ExamsModel> getExamsAsync() async {
    late ExamsModel exams;
    if (kDebugMode) {
      var json = JsonDecoder()
          .convert(await rootBundle.loadString("assets/exams.json"));
      exams = ExamsModel.fromJson(json);
    } else {
      exams = await api.getExamsAsync();
    }

    return exams;
  }

  updateExamsAsync(ExamsModel exams) {
    // TODO
  }
}
