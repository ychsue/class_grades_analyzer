import 'package:class_grades_analyzer/controllers/exam_controller.dart';
import 'package:class_grades_analyzer/controllers/mytab_controller.dart';
import 'package:class_grades_analyzer/modules/course/course_page.dart';
import 'package:class_grades_analyzer/modules/exam/exam_page.dart';
import 'package:class_grades_analyzer/modules/start/start_page.dart';
import 'package:class_grades_analyzer/modules/student/student_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final c = Get.find<ExamController>();
    final cTab = Get.find<MyTabController>();
    return Obx(() => Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: cTab.tNc.value.tabs,
            controller: cTab.tNc.value.controller,
          ),
          ),
        body:
            // Obx(() =>
            TabBarView(
          controller: cTab.tNc.value.controller,
          children: [
            StartPage(),
            ...((c.exams.value != null)
                ? [
                    ExamPage(),
                    StudentPage(),
                    CoursePage(),
                  ]
                : []),
          ],
        )
        // ),
        ));
  }
}
