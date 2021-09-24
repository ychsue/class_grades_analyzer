import 'dart:convert';

import 'one_pdf_declarer.dart';

extension FunForOnePdfDeclarer on OnePdfDeclarerModel {
  static String genStringFromExpression(
      {required dynamic input, String expression = ""}) {
    String result = "";
    if (expression == "") return result;

    List<String> inList = [];
    if (input is Map) {
      inList.add(jsonEncode(input));
      inList.addAll(input.values.map((e) => e.toString()).toList());
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
