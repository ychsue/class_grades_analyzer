import 'package:class_grades_analyzer/controllers/my_global_controller.dart';
import 'package:class_grades_analyzer/data/model/dimensions/tab_names.dart';
import 'package:class_grades_analyzer/data/model/grade_or_rank.dart';
import 'package:class_grades_analyzer/modules/home/set_visibility_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var gC = Get.find<MyGlobalController>();
    var axes = gC.cases.firstWhere((ele) => gC.tab.value == ele.value.main);
    return Drawer(
      child: ListView(
        children: [
          Center(
            child: Text(
              "設定要顯示者：" // I18N
              ,
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          Divider(),
          ListTile(
            title: Text('主軸：' + TabNames.name(axes.value.main)), // I18N
            leading: MyGlobalController.Tabs[TabNames.name(axes.value.main)],
            onTap: () {
              showDialog(
                  context: context,
                  builder: (ctx) {
                    return SetVisibilityDialog(
                        axes: axes, whichAxis: axes.value.main, gC: gC);
                  });
            },
          ),
          ListTile(
            title: Text('X軸：' + TabNames.name(axes.value.x)), // I18N
            leading: MyGlobalController.Tabs[TabNames.name(axes.value.x)],
            onTap: () {
              showDialog(
                  context: context,
                  builder: (ctx) {
                    return SetVisibilityDialog(
                        axes: axes, whichAxis: axes.value.x, gC: gC);
                  });
            },
          ),
          ListTile(
            title: Text('Y軸：' + TabNames.name(axes.value.y)), // I18N
            leading: MyGlobalController.Tabs[TabNames.name(axes.value.y)],
            onTap: () {
              showDialog(
                  context: context,
                  builder: (ctx) {
                    return SetVisibilityDialog(
                        axes: axes, whichAxis: axes.value.y, gC: gC);
                  });
            },
          ),
          Divider(),
          Center(
            child: Text(
              "成績或名次等：" // I18N
              ,
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          Divider(),
          ListTile(
            title: Obx(() => DropdownButton<GradeOrRankEnum>(
                  value: gC.gType.value,
                  items: GradeOrRankEnum.values
                      .map((e) => DropdownMenuItem(
                            child: Text(gC.gNames.value.enum2Name(e) ??
                                "${DateTime.now().toString()}"),
                            value: e,
                          ))
                      .toList(),
                  onChanged: (v) {
                    gC.gType.value = v ?? gC.gType.value;
                  },
                )),
          )
        ],
      ),
    );
  }
}
