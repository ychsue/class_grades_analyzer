import 'package:class_grades_analyzer/controllers/id_and_grade_keys_controller.dart';
import 'package:class_grades_analyzer/data/model/exams_model.dart';
import 'package:class_grades_analyzer/data/model/one_exam_model.dart';
import 'package:class_grades_analyzer/data/provider/from_excel_file/_get_1exam_from_sheet.dart';
import 'package:excel/excel.dart';
import 'package:get/get.dart';

getExamsFromExcel({
  required Excel excel,
}) {
  // Input from Getx's controller
  var c = Get.find<IdAndGradeKeysController>();
  final result = ExamsModel(idKeys: c.ids, gradeKeys: c.gradeKeys, exams: []);

  var examNames = excel.tables.keys.toList();
  result.examNames = examNames;

  for (var examName in examNames) {
    Sheet? sheet = excel.tables[examName];
    OneExamModel exam = getOneExamFromSheet(examName, sheet);
    if (exam.students.length == 0) continue;
    result.exams.add(exam);
  }
  return result;
}
