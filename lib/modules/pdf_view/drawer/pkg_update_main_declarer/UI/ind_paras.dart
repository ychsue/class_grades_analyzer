import 'package:flutter/material.dart';
import '../umd_controller.dart';

/// Parameters for different index types
///
/// For example, if it is for selN, it should show up a TextFormField for input
///
List<Widget> indParas(UMDController c) {
  final List<Widget> result = [];
  if (c.indType.value == IndDeclarerEnum.selN) {
    result.addAll([
      TextFormField(
        initialValue: c.stSelN.value,
        onChanged: (v) {
          c.stSelN.value = v;
        },
      ),
      if (c.selErrorMsg.value != "")
        Text(
          c.selErrorMsg.value,
          style: TextStyle(color: Colors.red),
        ),
      Divider(),
    ]);
  }
  return result;
}
