import 'package:class_grades_analyzer/modules/pdf_view/pdf_declare_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PdfViewPage extends StatefulWidget {
  PdfViewPage({Key? key}) : super(key: key);

  @override
  _PdfViewPageState createState() => _PdfViewPageState();
}

class _PdfViewPageState extends State<PdfViewPage> {
  static GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 0))
        .then((value) => _scaffoldKey.currentState?.openDrawer());
  }

  @override
  Widget build(BuildContext context) {
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
      body: Builder(
        builder: (ctx) {
          debugPrint("currentState: ${_scaffoldKey.currentState}");
          _scaffoldKey.currentState!.openDrawer();
          return Container();
        },
      ),
    );
  }
}
