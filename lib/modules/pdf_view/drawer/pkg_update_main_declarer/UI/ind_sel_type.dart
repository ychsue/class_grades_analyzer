import 'package:flutter/material.dart';
import '../umd_controller.dart';

List<Widget> indSelType(UMDController c) {
  return [
    Row(
      children: [
        Flexible(
          child: RadioListTile<IndDeclarerEnum>(
              title: Text("全選"), // I18N
              value: IndDeclarerEnum.all,
              groupValue: c.indType.value,
              onChanged: (v) {
                c.indType.value = v ?? IndDeclarerEnum.all;
              }),
        ),
        Flexible(
          child: RadioListTile<IndDeclarerEnum>(
              title: Text("選碼"), // I18N
              value: IndDeclarerEnum.selN,
              groupValue: c.indType.value,
              onChanged: (v) {
                c.indType.value = v ?? IndDeclarerEnum.all;
              }),
        ),
        Flexible(
          child: RadioListTile<IndDeclarerEnum>(
              title: Text("上頁設定"), // I18N
              value: IndDeclarerEnum.asTableView,
              groupValue: c.indType.value,
              onChanged: (v) {
                c.indType.value = v ?? IndDeclarerEnum.all;
              }),
        ),
      ],
      mainAxisSize: MainAxisSize.min,
    ),
  ];
}
