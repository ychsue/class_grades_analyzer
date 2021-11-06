import 'package:pdf/pdf.dart';

import 'gen_pdf/gen_pdf_doc.dart';
import 'drawer/pdf_declare_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'pdf_view_controller.dart';

import 'package:printing/printing.dart';

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
        final isOkay2Draw = controller.isOkay2Draw.value;
        return PdfPreview(
          initialPageFormat: PdfPageFormat.a4,
            build: (format) => genPdfDoc(format, controller, isOkay2Draw));
      }),
    );
  }
}
