import 'package:class_grades_analyzer/controllers/my_global_controller.dart';
import 'package:class_grades_analyzer/data/model/dimensions/tab_names.dart';
import 'package:class_grades_analyzer/modules/home/mytab_controller.dart';
import 'package:class_grades_analyzer/modules/course/course_page.dart';
import 'package:class_grades_analyzer/modules/exam/exam_page.dart';
import 'package:class_grades_analyzer/modules/home/my_drawer/my_drawer.dart';
import 'package:class_grades_analyzer/modules/start/start_page.dart';
import 'package:class_grades_analyzer/modules/student/student_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final c = Get.find<MyGlobalController>();
    final cTab = Get.find<MyTabController>();
    return Obx(() => Scaffold(
        drawer: (c.exams.value == null || c.tab.value == TabsEnum.home)
            ? null
            : MyDrawer(),
        appBar: AppBar(
          title: Text("導師成績分析專案"), // I18N
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
