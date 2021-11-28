import 'package:class_grades_analyzer/controllers/id_and_course_keys_controller.dart';
import 'package:class_grades_analyzer/data/model/exams_model.dart';
import 'package:class_grades_analyzer/data/model/one_exam_model.dart';
import 'package:class_grades_analyzer/data/provider/from_excel_file/one_exam/_get_1exam_from_sheet.dart';
import 'package:excel/excel.dart';
import 'package:get/get.dart';

getExamsFromExcel({
  required Excel excel,
}) {
  // Input from Getx's controller
  var c = Get.find<IdAndCourseKeysController>();
  final result = ExamsModel(idKeys: c.ids, courseKeys: c.courseKeys, exams: []);

  var examNames = excel.tables.keys.toList();
  result.examNames = examNames;

  for (var examName in examNames) {
    Sheet? sheet = excel.tables[examName];
    if (c.ignoredSheets.contains(examName)) continue;
    
    OneExamModel exam = getOneExamFromSheet(examName, sheet);
    if (exam.students.length == 0) continue;
    result.exams.add(exam);
  }
  return result;
}
