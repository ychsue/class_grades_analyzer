import 'package:class_grades_analyzer/data/model/dimensions/tab_names.dart';

class DimsModel {
  List<String> exam = [""];
  List<String> course = [""];
  List<Map<String, dynamic>> student = [
    {"座號": 1, "姓名": "XX昌"}
  ];

  DimsModel();

  DimsModel.fromJson(Map<String, dynamic> json) {
    this.fromJson(json);
  }

  List<dynamic>? getDimByEnum(TabsEnum dim) {
    switch (dim) {
      case TabsEnum.exam:
        return exam;
      case TabsEnum.student:
        return student;
      case TabsEnum.course:
        return course;
      default:
        return null;
    }
  }

  fromJson(Map<String, dynamic> json) {
    this.exam = List<String>.from(json['exam']);
    this.course = List<String>.from(json['course']);
    this.student = json['student'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['exam'] = this.exam;
    data['course'] = this.course;
    data['student'] = this.student;

    return data;
  }
}
