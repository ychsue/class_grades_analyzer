import 'package:class_grades_analyzer/modules/start/UI/%F0%9F%91%81%EF%B8%8Fsettings_4_all.dart';
import 'package:flutter/material.dart';

import 'functions/get_exams.dart';

class StartPage extends StatelessWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SettingsForAll(),
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
