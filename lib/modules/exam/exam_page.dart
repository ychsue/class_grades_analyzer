import 'package:class_grades_analyzer/modules/dims/dims_page.dart';
import 'package:flutter/material.dart';

class ExamPage extends StatelessWidget {
  const ExamPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              DimsPage(),
            ],
          ),
        ),
      ),
    );
  }
}
