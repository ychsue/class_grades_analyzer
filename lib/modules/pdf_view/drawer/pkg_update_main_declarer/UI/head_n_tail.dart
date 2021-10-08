import 'package:flutter/material.dart';
import '../umd_controller.dart';

List<Widget> headNTail(UMDController c) {
  return [
    Center(
      child: Text("標頭與標尾"),
    ), //I18N
    Divider(),
    TextFormField(
      decoration: InputDecoration(label: Text("標頭")), // I18N
      initialValue: c.headerScript.value,
      onChanged: (v) {
        c.headerScript.value = v;
      },
    ),
    TextFormField(
      decoration: InputDecoration(label: Text("標尾")), // I18N
      initialValue: c.bottomScript.value,
      onChanged: (v) {
        c.bottomScript.value = v;
      },
    ),
  ];
}
