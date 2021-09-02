import 'package:class_grades_analyzer/data/model/dimensions/tab_names.dart';
import 'package:class_grades_analyzer/data/model/pair.dart';

class DimsModel {
  List<PairModel<String, bool>> exam = [];
  List<PairModel<String, bool>> course = [];
  List<PairModel<Map<String, dynamic>, bool>> student = [
    PairModel({"座號": 1, "姓名": "XX昌"}, true)
  ];

  DimsModel();

  DimsModel.fromJson(Map<String, dynamic> json) {
    this.fromJson(json);
  }

  DimsModel.of(DimsModel dims) {
    this.fromJson(dims.toJson());
  }

  List<PairModel<dynamic, bool>>? getDimByEnum(TabsEnum dim) {
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
    this.exam = List<PairModel<String, bool>>.from(json['exam']);
    this.course = List<PairModel<String, bool>>.from(json['course']);
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
