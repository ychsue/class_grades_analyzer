import 'package:class_grades_analyzer/data/model/one_exam_row_model.dart';
import 'package:class_grades_analyzer/data/model/one_record_model.dart';
import 'package:flutter/foundation.dart';

class OneExamModel {
  String name = "110_1";
  List<OneExamRowModel> students = [];

  OneExamModel({required this.name, required this.students});

  OneExamRowModel getStudent(Map<String, dynamic> id) {
    late OneExamRowModel student;
    try {
      student = students.firstWhere((ele) => mapEquals(id, ele.id));
    } catch (e) {
      // Sometimes, there might be some new students to get into the teacher's class
      var courses = students[0].courses;
      courses = courses.map((key, value) => MapEntry(key, OneRecordModel()));
      student = OneExamRowModel(id: id, courses: courses);
    }
    return student;
  }

  add(OneExamRowModel student) {
    students.add(student);
  }

  addAll(List<OneExamRowModel> sts) {
    students.addAll(sts);
  }

  OneExamModel.fromJson(Map<String, dynamic> json) {
    var name = json['name'];
    this.name = name;
    var students = (json['students'] as List<dynamic>)
        .map((e) => OneExamRowModel.fromJson(e));
    this.students = students.toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['students'] = this.students;
    data['name'] = this.name;
    return data;
  }
}
