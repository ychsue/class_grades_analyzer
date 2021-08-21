import 'package:class_grades_analyzer/controllers/my_global_controller.dart';
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
              Get.snackbar(gC.tab.value, gC.tab.value);
            },
          ), // I18N
        ],
      ),
    );
  }
}
