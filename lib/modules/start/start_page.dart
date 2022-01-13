import 'package:class_grades_analyzer/controllers/id_and_course_keys_controller.dart';
import 'package:class_grades_analyzer/controllers/my_global_controller.dart';
import 'package:class_grades_analyzer/data/provider/for_pdf_declarer.dart';
import 'package:class_grades_analyzer/modules/start/UI/%F0%9F%91%81%EF%B8%8Fsettings_4_all.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'functions/get_exams.dart';

class StartPage extends StatelessWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TheTitle(),
        Expanded(
          child: ListView(
            children: [
              SettingsForAll(),
            ],
          ),
        ),
        Center(
          child: ElevatedButton(
            child: Text("Get an Excel File"),
            onPressed: getExams,
          ),
        ),
      ],
    );
  }

}

class TheTitle extends StatelessWidget {
  const TheTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final c = Get.find<IdAndCourseKeysController>();
    return Stack(
      children: [
        Container(
          alignment: Alignment.topCenter,
          padding: EdgeInsets.all(8),
          child: Text("載入前設定"), //I18N
        ),
        Positioned(
            right: 8,
            child: IconButton(
                onPressed: () async {
                  c.write2GetStorage();
                  // await IOShowCases.saveToStorageAsync();
                  final gc = Get.find<MyGlobalController>();
                  await ForPDFDeclarer.write(gc.allMainPdfDeclares);
                },
                icon: Icon(Icons.archive)))
      ],
    ); // I18N
  }
}
