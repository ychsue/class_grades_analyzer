import 'package:class_grades_analyzer/data/model/one_exam_row_model.dart';

class OneExamModel {
  String id = "110_1";
  List<OneExamRowModel> students = [];

  // #region rank
  /// [rank] is a List<int> and its based on the sequence of [students]
  ///
  List<int>? _rank;
  List<int> get rank {
    if (_rank == null) {
      var sorted = List.of(students);
      sorted.sort((a, b) {
        return (-(a.average ?? 0) + (b.average ?? 0)).toInt();
      });
      _rank = students.map((e) => sorted.indexOf(e)).toList();
    }
    return _rank!;
  }
  // #endregion rank

  // #region highest, lowest
  /// [highest] is {"課目": List of ith student}
  Map<String, List<int>>? _highest, _lowest;
  Map<String, List<int>>? get highest {
    if (_highest == null && students.length > 0) {
      for (var key in students[0].data.keys) {
        List<int> highest = [];
        List<int> lowest = [];
        num? hValue;
        num? lValue;
        for (var i0 = 0; i0 < students.length; i0++) {
          var iStValue = students[i0].data[key];
          if (iStValue != null) {
            if (hValue == null || hValue <= iStValue) {
              if ((hValue ?? -100) < iStValue) highest.clear();
              hValue = iStValue;
              highest.add(i0);
              if (lValue != null) continue;
            }
          }
          if (iStValue != null) {
            if (lValue == null || lValue >= iStValue) {
              if ((lValue ?? 1000000) > iStValue) lowest.clear();
              lValue = iStValue;
              lowest.add(i0);
            }
          }
        }

        if (highest.length > 0) {
          _highest ??= {};
          _highest!.addAll({key: highest});
        }
        if (lowest.length > 0) {
          _lowest ??= {};
          _lowest!.addAll({key: lowest});
        }
      }
    }
    return _highest;
  }

  Map<String, List<int>>? get lowest {
    highest; // Get highest and lowest at once.
    return _lowest;
  }
  // #endregion highest, lowest

// #region averages
  Map<String, num>? _averages;
  Map<String, num>? get averages {
    if (_averages == null && students.length > 0) {
      for (var key in students[0].data.keys) {
        var n = 0;
        var nWithNull = 0;
        num sum = 0;
        students.forEach((ele) {
          var value = ele.data[key];
          nWithNull++;
          if (value is num) {
            n++;
            sum += value;
          } else {
            return;
          }
        });
        if (_averages == null) _averages = {};
        n = nWithNull; // TODO   應該用 if 來選擇
        _averages!.addAll({key: (n > 0) ? (sum / n) : 0});
      }
    }
    return _averages;
  }
// #endregion averages

  OneExamModel({required this.id, required this.students});

  add(OneExamRowModel student) {
    students.add(student);
  }

  addAll(List<OneExamRowModel> sts) {
    students.addAll(sts);
  }

  OneExamModel.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.students = json['students'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['students'] = this.students;
    data['id'] = this.id;
    return data;
  }
}
