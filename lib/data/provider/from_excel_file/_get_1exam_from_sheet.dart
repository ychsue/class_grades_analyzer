import 'dart:math';

import 'package:class_grades_analyzer/controllers/id_and_grade_keys_controller.dart';
import 'package:class_grades_analyzer/data/model/one_exam_model.dart';
import 'package:class_grades_analyzer/data/model/one_exam_row_model.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

OneExamModel getOneExamFromSheet(
  String examName,
  Sheet? sheet,
) {
  // 1. Input from Getx's controller
  var c = Get.find<IdAndGradeKeysController>();
  var ids = List.of(c.ids);
  var gradeKeys = Map.of(c.gradeKeys);
  Map<String, int> idC = {};
  Map<String, int> gradeKeyC = {};

  int? _maxHeadRow;

  final result = OneExamModel(id: examName, students: []);
  // 2. Find the keys' Column at first
  if (sheet == null) return result;

  for (int irow = 0; irow < sheet.rows.length; irow++) {
    var row = sheet.rows[irow];
    var hasFoundAllKeys = false;
    for (int icol = 0; icol < row.length; icol++) {
      var item = row[icol];
      var value = (!(item is Data)) ? item : item.value;
      if (value is String) {
        value = value.replaceAll("\n", "").trim();
        if (ids.contains(value)) {
          idC.addAll({value: icol});
          ids.remove(value);
          _maxHeadRow = (_maxHeadRow == null) ? irow : max(irow, _maxHeadRow);
        } else if (gradeKeys.containsKey(value)) {
          gradeKeyC.addAll({value: icol});
          gradeKeys.remove(value);
          _maxHeadRow = (_maxHeadRow == null) ? irow : max(irow, _maxHeadRow);
        }
      }
      hasFoundAllKeys = (ids.length == 0) && (gradeKeys.length == 0);
      if (hasFoundAllKeys) break;
    }
    if (hasFoundAllKeys) break;
  }

  // 3. Generate students' data
  if (_maxHeadRow == null) return result;

  for (var i = (_maxHeadRow + 1); i < sheet.rows.length; i++) {
    var row = sheet.rows[i];
    var id = idC.map((key, col) =>
        MapEntry(key, (!(row[col] is Data)) ? row[col] : row[col]?.value));
    var isValid = false;
    id.forEach((key, value) {
      isValid = isValid || (value != null);
    });
    // if [id]'s elements are all null, skip this one
    if (!isValid) continue;

    if (id['座號'] == 30) {
      debugPrint("$id");
    }

    Map<String, dynamic> grades = {};
    var hasFormula = false;
    for (var key in gradeKeyC.keys) {
      var col = gradeKeyC[key];
      if (row[col!] is Formula) {
        hasFormula = true;
        break; // TODO  At this moment, it cannot deal with a Formula
      }
      grades.addAll({key: (!(row[col] is Data)) ? row[col] : row[col]?.value});
    }
    if (hasFormula) continue;

    // grades = gradeKeyC.map((key, col) => MapEntry(key, row[col]?.value));
    var student = OneExamRowModel(id: id, data: grades);
    result.students.add(student);
  }

  return result;
}
