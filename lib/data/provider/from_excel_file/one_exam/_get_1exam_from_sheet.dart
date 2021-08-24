import 'package:class_grades_analyzer/controllers/id_and_course_keys_controller.dart';
import 'package:class_grades_analyzer/data/model/one_exam_model.dart';
import 'package:class_grades_analyzer/data/provider/from_excel_file/one_exam/__fill_the_ranks.dart';
import 'package:class_grades_analyzer/data/provider/from_excel_file/one_exam/__get_key_columns.dart';
import 'package:class_grades_analyzer/data/provider/from_excel_file/one_exam/__get_one_student.dart';
import 'package:excel/excel.dart';
import 'package:get/get.dart';
import '__get_key_columns.dart';

OneExamModel getOneExamFromSheet(
  String examName,
  Sheet? sheet,
) {
  // Initialize result
  OneExamModel result = OneExamModel(name: examName, students: []);

  // 1. Input from Getx's controller
  var c = Get.find<IdAndCourseKeysController>();

  // 2. Get ids' and courses' column
  if (sheet == null) return result;
  final icKeys = getKeyColumns(sheet, List.of(c.ids), Map.of(c.courseKeys));
  int? _maxHeadRow = icKeys.maxHeadRow;

  if (_maxHeadRow == null) return result;

  // 3. Get students' data
  for (var i = (_maxHeadRow + 1); i < sheet.rows.length; i++) {
    var row = sheet.rows[i];
    var student = getOneStudent(icKeys, row);
    if (student != null) result.students.add(student);
  }

  // 4. Initialize vCourses
  for (var student in result.students) {
    student.vCourses.sum;
    student.vCourses.average;
  }

  // 5. Calculate the rank
  fillTheRanks(result, icKeys);

  // TODO
  return result;
}
