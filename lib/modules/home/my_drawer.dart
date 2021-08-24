import 'dart:convert';

import 'package:class_grades_analyzer/controllers/my_global_controller.dart';
import 'package:class_grades_analyzer/data/model/dimensions/tab_names.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var gC = Get.find<MyGlobalController>();
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            title: Text('想看對象'),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (ctx) {
                    return SimpleDialog(
                      titlePadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      title: Container(
                        color: Colors.lime,
                        padding: EdgeInsets.fromLTRB(0, 24, 24, 0),
                        child: ListTile(
                          leading: Checkbox(value: true, onChanged: null),
                          title: Text(gC.tab.value),
                        ),
                      ),
                      children: [
                        Divider(),
                        if (gC.tab.value == TabNames.exam)
                          ...gC.currentExamKeys.map((e) => ListTile(
                              leading: Checkbox(
                                onChanged: null,
                                value: true,
                              ),
                              title: Text(e)))
                        else if (gC.tab.value == TabNames.student)
                          ...gC.currentIds
                              .map((e) => ListTile(title: Text(jsonEncode(e))))
                        else if (gC.tab.value == TabNames.course)
                          ...gC.currentCourseKeys
                              .map((e) => ListTile(title: Text(e)))
                        else
                          ...[]
                      ],
                    );
                  });
            },
              // Get.snackbar(gC.tab.value, gC.tab.value);
            
          ), // I18N
        ],
      ),
    );
  }
}
