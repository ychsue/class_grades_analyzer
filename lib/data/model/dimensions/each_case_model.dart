import 'package:class_grades_analyzer/data/model/dimensions/tab_names.dart';

class EachCaseModel {
  List<String> exam = [""];
  List<String> course = [""];
  List<Map<String, dynamic>> student = [
    {"座號": 1, "姓名": "XX昌"}
  ];
  Tabs main = (Tabs.exam);
  Tabs x = (Tabs.course);
  Tabs y = (Tabs.student);

  EachCaseModel({required this.main, required this.x, required this.y});

  EachCaseModel.fromJson(Map<String, dynamic> json) {
    this.main = json['main'];
    this.x = json['x'];
    this.y = json['y'];
    this.exam = List<String>.from(json['exam']);
    this.course = List<String>.from(json['course']);
    this.student = json['student'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['main'] = this.main;
    data['x'] = this.x;
    data['y'] = this.y;
    data['exam'] = this.exam;
    data['course'] = this.course;
    data['student'] = this.student;

    return data;
  }
}
