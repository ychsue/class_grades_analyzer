import 'package:class_grades_analyzer/data/model/one_exam_row_model.dart';

class OneExamModel {
  String name = "110_1";
  List<OneExamRowModel> students = [];

  OneExamModel({required this.name, required this.students});

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
