import 'dart:convert';

import 'package:class_grades_analyzer/data/provider/from_excel_file/index.dart';
import 'package:class_grades_analyzer/data/repository/get_exams.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: ElevatedButton(
            child: Text("open file"),
            onPressed: () => getExams(),
          ),
        ));
  }

  getExams() async {
    var examRepo = GetExamsRepository(FromExcelFileApi());
    var result = await examRepo.getExamsAsync();
    debugPrint(jsonEncode(result));
    return result;
  }
}
