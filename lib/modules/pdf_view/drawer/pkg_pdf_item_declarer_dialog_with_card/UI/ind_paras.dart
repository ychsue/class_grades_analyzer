import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Parameters for different index types
///
/// For example, if it is for selN, it should show up a TextFormField for input
///
List<Widget> indParas(RxString stSelN, RxString errMsg) {
  final List<Widget> result = [];
  result.addAll([
    TextFormField(
      initialValue: stSelN.value,
      onChanged: (v) {
        stSelN.value = v;
      },
    ),
    if (errMsg.value != "")
      Text(
        errMsg.value,
        style: TextStyle(color: Colors.red),
      ),
    Divider(),
  ]);
  return result;
}
