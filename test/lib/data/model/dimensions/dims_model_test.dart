import 'dart:convert';

import 'package:class_grades_analyzer/data/model/dimensions/dims_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_storage/get_storage.dart';

void main() {
  group("Test toJson and fromJson", () {
    late DimsModel aDim;
    setUp(() {
      aDim = DimsModel();
    });
    test("toJson then write it into GetStorage and read it", () {
      var json = aDim.toJson();
      var box = GetStorage();
      box.write("data", json);
      var data = box.read("data");
      print(jsonEncode(data));
      expect(data["student"][0]["t1"], jsonEncode(aDim.student[0].t1));
    });

    test("fromJson", () {
      var json = aDim.toJson();
      var data = DimsModel.fromJson(json);
      expect(aDim.student.length, 1);
      print(jsonEncode(data));
      expect(aDim.student[0].t1, data.student[0].t1);
    });
  });
}
