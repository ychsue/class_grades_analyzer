import 'package:class_grades_analyzer/data/model/extensions/virtual_courses.dart';
import 'package:class_grades_analyzer/data/model/one_exam_row_model.dart';
import 'package:class_grades_analyzer/data/model/one_record_model.dart';

class VCoursesModel {
  OneRecordModel? _sum;
  OneRecordModel? _average;
  OneExamRowModel? parent;

  OneRecordModel? get sum {
    if (_sum == null && parent != null) {
      _sum = OneRecordModel()..numb = parent!.sum();
    }
    return _sum;
  }

  OneRecordModel? get average {
    if (_average == null && parent != null) {
      _average = OneRecordModel()..numb = parent!.average();
    }
    return _average;
  }

  VCoursesModel({this.parent});

  VCoursesModel.fromJson(Map<String, dynamic> json) {
    this._sum = json['sum'];
    this._average = json['average'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sum'] = this.sum;
    data['average'] = this.average;
    return data;
  }
}
