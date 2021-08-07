import 'package:class_grades_analyzer/controllers/id_and_grade_keys_controller.dart';
import 'package:get/get.dart';

/// 一次大考的成績中每個人的各科成績
/// [id] : 由於考量到可能有學生轉進或轉出，只靠 "座號" 好像不夠，
///         所以，規定其為 {A:0, B:NAME ...}`
/// [data] : 以 Map<String, dynamic> 來存各科成績
class OneExamRowModel {
  Map<String, dynamic> id = {};
  Map<String, dynamic> data = {};

  // #region total
  num? _total;
  num? get total {
    if (_total == null) {
      data.values.forEach((value) {
        if (value is num) {
          _total = (_total ?? 0) + value;
        }
      });
    }
    return _total;
  }
  // #endregion total

  // #region average
  num? _avg;
  num? get average {
    if (_avg == null) {
      var c = Get.find<IdAndGradeKeysController>();
      var sumW = 0;
      var sum = 0.0;

      data.forEach((key, value) {
        var w = c.gradeKeys[key] ?? 0;
        sumW += w;
        if (value is num) {
          sum += w * value;
        }
      });
      _avg = sum / sumW;
    }
    return _avg;
  }
  // #endregion average

  OneExamRowModel({required this.id, required this.data});

  OneExamRowModel.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['data'] = this.data;
    data['id'] = this.id;
    return data;
  }
}
