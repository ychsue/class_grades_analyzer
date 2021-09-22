import 'dart:convert';

import 'package:class_grades_analyzer/modules/pdf_view/pdf_declare_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'pdf_view_controller.dart';

class PdfViewPage extends GetView<PdfViewController> {
  static GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 0))
        .then((value) => _scaffoldKey.currentState?.openDrawer());
    return Scaffold(
      key: _scaffoldKey,
      drawer: PdfDeclareDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.red,
        shadowColor: Colors.amber,
        centerTitle: true,
        title: Text("要顯示的圖表"), //I18N
        actions: [
          IconButton(
            onPressed: () => Get.back(),
            icon: Icon(Icons.arrow_back),
          ),
        ],
      ),
      body: Obx(() {
        var buf = controller.currentDeclare.value;
        return Text(jsonEncode(buf)); // TODO
      }),
    );
  }
}
