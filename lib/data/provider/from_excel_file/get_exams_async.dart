import 'package:class_grades_analyzer/data/model/exams_model.dart';
import 'package:class_grades_analyzer/data/provider/from_excel_file/_get_exams_from_excel.dart';

import '_get_excel_from_bytes_async.dart';

Future<ExamsModel> getExamsAsync() async {
  var excel = await getExcelFromBytesAsync();
  ExamsModel data = getExamsFromExcel(excel: excel);

  return data;
}
