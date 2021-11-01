import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../pid_controller.dart';

List<Widget> indSelType(Rx<IndDeclarerEnum> type) {
  return [
    Row(
      children: [
        Flexible(
          child: RadioListTile<IndDeclarerEnum>(
              title: Text("全選"), // I18N
              value: IndDeclarerEnum.all,
              groupValue: type.value,
              onChanged: (v) {
                type.value = v ?? IndDeclarerEnum.all;
              }),
        ),
        Flexible(
          child: RadioListTile<IndDeclarerEnum>(
              title: Text("選碼"), // I18N
              value: IndDeclarerEnum.selN,
              groupValue: type.value,
              onChanged: (v) {
                type.value = v ?? IndDeclarerEnum.all;
              }),
        ),
        Flexible(
          child: RadioListTile<IndDeclarerEnum>(
              title: Text("同上頁"), // I18N
              value: IndDeclarerEnum.asTableView,
              groupValue: type.value,
              onChanged: (v) {
                type.value = v ?? IndDeclarerEnum.all;
              }),
        ),
      ],
      mainAxisSize: MainAxisSize.min,
    ),
  ];
}
