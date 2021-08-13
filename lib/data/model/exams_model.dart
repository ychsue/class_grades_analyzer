import 'package:class_grades_analyzer/data/model/one_exam_model.dart';
import '../model/id_keys_model.dart';
import 'course_keys_model.dart';

class ExamsModel {
  IdKeysModel idKeys = [];
  CourseKeysModel courseKeys = {};
  List<OneExamModel> exams = [];
  List<String> examNames = [];

  add(OneExamModel exam) {
    exams.add(exam);
  }

  addAll(List<OneExamModel> exams) {
    exams.addAll(exams);
  }

  ExamsModel(
      {required this.idKeys, required this.courseKeys, required this.exams});

  ExamsModel.fromJson(Map<String, dynamic> json) {
    this.idKeys = json['idKeys'];
    this.courseKeys = json['courseKeys'];
    this.exams = json['exams'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['courseKeys'] = this.courseKeys;
    data['idKeys'] = this.idKeys;
    data['exams'] = this.exams;
    return data;
  }
}
