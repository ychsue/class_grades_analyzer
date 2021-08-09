import 'package:class_grades_analyzer/data/model/exams_model.dart';
import 'package:class_grades_analyzer/data/provider/from_excel_file/_get_exams_from_excel.dart';
import 'package:class_grades_analyzer/modules/doing_sth/doing_sth_controller.dart';
import 'package:get/get.dart';

import '_get_excel_from_bytes_async.dart';

Future<ExamsModel> getExamsAsync() async {
  var c = Get.find<DoingSthController>();
  c.start(0, 1);
  c.title.value = "匯入Excel檔案"; //I18N
  var excel = await getExcelFromBytesAsync();

  c.title.value = "已取得 Excel 資料"; //I18N
  c.start(0.5, 1.0);


  ExamsModel data = getExamsFromExcel(excel: excel);
  // await Future.delayed(Duration(seconds: 10));
  c.done();
  return data;
}
