import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import '../sel_n_2_list.dart';

void main() {
  group("Check", () {
    test('能解析4', () {
      final result = selN2List("4");
      expect(result.length, 1);
    });
    test('能解析1~5', () {
      final result = selN2List("1~5");
      expect(result.length, 5);
    });
    test('能解析3~1,4', () {
      final result = selN2List("3~1,4");
      expect(result.length, 4);
      expect(result[0], 3);
      expect(result[2], 1);
      expect(result[3], 4);
    });
    test('Capture exception', () {
      expect(() => selN2List("4-6"), throwsA(predicate((p0) {
        final exc = p0 as dynamic;
        debugPrint(p0.toString());
        return exc.message.contains('2~4,1');
      })));
    });
    test('Capture exception inside', () {
      expect(() => selN2List("4~6,3~4~7"), throwsA(predicate((p0) {
        final exc = p0 as dynamic;
        debugPrint(p0.toString());
        return exc.message.contains('3~4~7');
      })));
    });
  });
}
