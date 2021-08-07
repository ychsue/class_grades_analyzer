import 'package:class_grades_analyzer/data/model/one_exam_model.dart';
import '../model/id_keys_model.dart';
import '../model/grade_keys_model.dart';

class ExamsModel {
  IdKeysModel idKeys = [];
  GradeKeysModel gradeKeys = {};
  List<OneExamModel> exams = [];
  List<String> examNames = [];

  add(OneExamModel exam) {
    exams.add(exam);
  }

  addAll(List<OneExamModel> exams) {
    exams.addAll(exams);
  }

  ExamsModel(
      {required this.idKeys, required this.gradeKeys, required this.exams});

  ExamsModel.fromJson(Map<String, dynamic> json) {
    this.idKeys = json['idKeys'];
    this.gradeKeys = json['gradeKeys'];
    this.exams = json['exams'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['gradKeys'] = this.gradeKeys;
    data['idKeys'] = this.idKeys;
    data['exams'] = this.exams;
    return data;
  }
}
