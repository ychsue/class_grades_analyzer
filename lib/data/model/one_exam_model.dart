import 'package:class_grades_analyzer/data/model/one_exam_row_model.dart';

class OneExamModel {
  String id = "110_1";
  List<OneExamRowModel> students = [];

  OneExamModel({required this.id, required this.students});

  add(OneExamRowModel student) {
    students.add(student);
  }

  addAll(List<OneExamRowModel> sts) {
    students.addAll(sts);
  }

  OneExamModel.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.students = json['students'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['students'] = this.students;
    data['id'] = this.id;
    return data;
  }
}
