import 'dart:convert';

import 'package:class_grades_analyzer/data/model/pair.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_storage/get_storage.dart';

void main() {
  group("Test toJson", () {
    late PairModel<String, bool> exam;
    late PairModel<Map<String, dynamic>, bool> student;
    setUp(() {
      exam = PairModel("國文", false);
      student = PairModel({"座號": 1, "姓名": "XX昌"}, true);
    });
    test("exam toJson", () {
      var json = exam.toJson();
      expect(json["t1"], jsonEncode(exam.t1));
      expect(json["t2"], jsonEncode(exam.t2));
    });
    test("student toJson", () {
      var json = student.toJson();
      expect(json["t1"], jsonEncode(student.t1));
      expect(json["t2"], jsonEncode(student.t2));
    });
    test('student write into getStorage', () {
      var box = GetStorage();
      var json = student.toJson();
      // Write into
      box.write("student", json);
      var jsonNew = box.read("student");
      expect(jsonNew["t1"], jsonEncode(student.t1));
      expect(jsonNew["t2"], jsonEncode(student.t2));
    });
  });
  group("Test fromJson", () {
    late PairModel<String, bool> exam;
    late PairModel<Map<String, dynamic>, bool> student;
    setUp(() {
      exam = PairModel("國文", false);
      student = PairModel({"座號": 1, "姓名": "XX昌"}, true);
    });
    test("exam fromJson", () {
      var json = exam.toJson();
      var data = PairModel.fromJson(json);
      expect(data.t1, exam.t1);
      expect(data.t2, exam.t2);
    });
    test("student fromJson", () {
      var json = student.toJson();
      var data = PairModel.fromJson(json);
      expect(data.t1, student.t1);
      expect(data.t2, student.t2);
    });
  });
}
