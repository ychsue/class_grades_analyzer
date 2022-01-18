import 'package:class_grades_analyzer/data/model/dimensions/tab_names.dart';
import 'package:class_grades_analyzer/data/model/pair.dart';

class DimsModel {
  List<PairModel<String, bool>> exam = [];
  List<PairModel<String, bool>> course = [];
  List<PairModel<Map<String, dynamic>, bool>> student = [
    PairModel({"座號": 1, "姓名": "XX昌"}, true)
  ];

  DimsModel();

  DimsModel.fromJson(dynamic json) {
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

  fromJson(dynamic jsonIn) {
    final iType = jsonIn.runtimeType.toString();
    late Map<String, List<dynamic>> json;
    if (iType == "_JsonMap" ||
        iType.contains("Map") ||
        iType.contains("minified")) {
      // minified:: for released one
      json = Map<String, List<dynamic>>.from(jsonIn);
    } else {
      return {};
    }
    this.exam = List<PairModel<String, bool>>.from(
      json['exam']!.map((e) => PairModel<String, bool>.fromJson(e)),
    );
    this.course = List<PairModel<String, bool>>.from(
      json['course']!.map((e) => PairModel<String, bool>.fromJson(e)),
    );
    this.student = List<PairModel<Map<String, dynamic>, bool>>.from(
      json['student']!
          .map((e) => PairModel<Map<String, dynamic>, bool>.fromJson(e)),
    );
  }

  Map<String, List<dynamic>> toJson() {
    final Map<String, List<dynamic>> data = new Map<String, List<dynamic>>();
    data['exam'] = this.exam.map((e) => e.toJson()).toList();
    data['course'] = this.course.map((e) => e.toJson()).toList();
    data['student'] = this.student.map((e) => e.toJson()).toList();

    return data;
  }
}
