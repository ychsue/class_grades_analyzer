import 'dart:convert';

import 'package:class_grades_analyzer/data/model/exams_model.dart';
import 'package:flutter/services.dart';
import '../provider/from_excel_file/index.dart';
import 'package:flutter/foundation.dart';

class GetExamsRepository {
  final FromExcelFileApi api;

  GetExamsRepository(this.api);

  Future<ExamsModel> getExamsAsync() async {
    if (kDebugMode) {
      var json = JsonDecoder()
          .convert(await rootBundle.loadString("assets/exams.json"));
      return ExamsModel.fromJson(json);
    } else {
      return await api.getExamsAsync();
    }
  }

  updateExamsAsync(ExamsModel exams) {
    // TODO
  }
}
