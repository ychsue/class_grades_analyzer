import 'package:class_grades_analyzer/data/model/one_exam_row_model.dart';
import 'package:class_grades_analyzer/data/model/one_record_model.dart';
import 'package:class_grades_analyzer/data/provider/from_excel_file/one_exam/__get_key_columns.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';

OneExamRowModel? getOneStudent(ICKeys icKeys, List<dynamic> row) {
  var idC = icKeys.idC;
  var courseKeyC = icKeys.courseKeyC;
  var id = idC.map((key, col) =>
      MapEntry(key, (!(row[col] is Data)) ? row[col] : row[col]?.value));
  var isValid = false;
  id.forEach((key, value) {
    isValid = isValid || (value != null);
  });
  // if [id]'s elements are all null, skip this one
  if (!isValid) return null;

  if (id['座號'] == 30) {
    debugPrint("$id");
  }

  Map<String, OneRecordModel> courses = {};
  var hasFormula = false;
  for (var key in courseKeyC.keys) {
    var col = courseKeyC[key];
    if (row[col!] is Formula) {
      hasFormula = true;
      break; // TODO  At this moment, it cannot deal with a Formula
    }
    OneRecordModel data = OneRecordModel(
        data: (!(row[col] is Data)) ? row[col] : row[col]?.value);
    data.numb = data
        .data; // TODO: It need a function to check whether it needs a mapping function
    courses.addAll({key: data});
  }
  if (hasFormula) return null;

  // grades = gradeKeyC.map((key, col) => MapEntry(key, row[col]?.value));
  var student = OneExamRowModel(id: id, courses: courses);

  return student;
}
