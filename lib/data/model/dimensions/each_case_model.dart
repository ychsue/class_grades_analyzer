import 'package:class_grades_analyzer/data/model/dimensions/dims_model.dart';
import 'package:class_grades_analyzer/data/model/dimensions/tab_names.dart';

class EachCaseModel extends DimsModel {
  // List<String> exam = [""];
  // List<String> course = [""];
  // List<Map<String, dynamic>> student = [
  //   {"座號": 1, "姓名": "XX昌"}
  // ];
  TabsEnum main = (TabsEnum.exam);
  TabsEnum x = (TabsEnum.course);
  TabsEnum y = (TabsEnum.student);

  EachCaseModel({required this.main, required this.x, required this.y});

  @override
  EachCaseModel.fromJson(Map<String, dynamic> json) {
    super.fromJson(json);
    this.main = json['main'];
    this.x = json['x'];
    this.y = json['y'];
    this.exam = List<String>.from(json['exam']);
    this.course = List<String>.from(json['course']);
    this.student = json['student'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    data['main'] = this.main;
    data['x'] = this.x;
    data['y'] = this.y;

    return data;
  }
}
