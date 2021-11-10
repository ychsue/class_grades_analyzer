import 'dart:convert';

import 'one_pdf_declarer.dart';

extension FunForOnePdfDeclarer on OnePdfDeclarerModel {
  static String genStringFromExpression(
      {required dynamic input, String expression = ""}) {
    String result = "";
    if (expression == "") return result;

    List<String> inList = [];
    final iType = input.runtimeType.toString();
    if (iType == "_JsonMap" || iType.contains("Map")) {
      inList.add(jsonEncode(input));
      final allEle = List<String>.from(input.values.map((e) => e.toString()));
      inList.addAll(allEle);
    } else if (input is String) {
      inList.add(input);
      inList.addAll(input.split("_"));
    }

    result = expression;
    for (var i0 = 0; i0 < inList.length; i0++) {
      result = result.replaceAll("\$$i0", inList[i0]);
    }

    return result;
  }
}
