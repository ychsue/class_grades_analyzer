import 'package:class_grades_analyzer/controllers/id_and_course_keys_controller.dart';
import 'package:class_grades_analyzer/data/model/one_record_model.dart';
import 'package:class_grades_analyzer/data/model/v_courses_model.dart';
import 'package:get/get.dart';

/// 一次大考的成績中每個人的各科成績
/// [id] : 由於考量到可能有學生轉進或轉出，只靠 "座號" 好像不夠，
///         所以，規定其為 {A:0, B:NAME ...}`
/// [courses] : 以 Map<String, dynamic> 來存各科成績
class OneExamRowModel {
  Map<String, dynamic> id = {};
  Map<String, OneRecordModel> courses = {};
  late VCoursesModel vCourses; // = VCoursesModel();

  OneExamRowModel({required this.id, required this.courses}) {
    vCourses = VCoursesModel(parent: this);
  }

  OneExamRowModel.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.courses = json['courses'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['courses'] = this.courses;
    data['id'] = this.id;
    return data;
  }
}
