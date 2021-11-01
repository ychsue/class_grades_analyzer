import 'package:class_grades_analyzer/controllers/my_global_controller.dart';
import 'package:class_grades_analyzer/data/model/dimensions/tab_names.dart';
import 'package:class_grades_analyzer/data/model/pdf/one_pdf_declarer.dart';
import 'package:class_grades_analyzer/modules/pdf_view/pdf_view_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'show_items_for_manipulate/show_items_for_manipulate.dart';
import 'update_main_declarer.dart';

class PdfDeclareDrawer extends StatelessWidget {
  const PdfDeclareDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final c = Get.find<PdfViewController>();
    final gC = c.gC;
    final axes = gC.cases.firstWhere((ele) => ele.value.main == gC.tab.value);
    final List<OnePdfDeclarerModel> modifieditems = [];
    return Drawer(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Text(
              "宣告想列印出來的", //I18N
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          Divider(),
          // #region 告知目前座標
          Center(
            child: Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("主要："), //I18N
                        MyGlobalController
                                .Tabs[TabNames.name(axes.value.main)] ??
                            Placeholder(),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("X軸："), //I18N
                        MyGlobalController.Tabs[TabNames.name(axes.value.x)] ??
                            Placeholder(),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("Y軸："), //I18N
                        MyGlobalController.Tabs[TabNames.name(axes.value.y)] ??
                            Placeholder(),
                      ],
                    ),
                  ],
                )),
          ),
          Divider(),
          // #endregion 告知目前座標

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                onPressed: () {
                  updateMainDeclarer(
                    context,
                    c.currentDeclare,
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("設定 "), //I18N
                    MyGlobalController.Tabs[TabNames.name(axes.value.main)] ??
                        Placeholder(),
                    Text(" 裏要顯示者"), //I18N
                  ],
                )),
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  onPressed: () {
                    if (modifieditems.length != 0) {
                      // if something has been modified
                      c.currentDeclare.value.children.clear();
                      c.currentDeclare.value.children.addAll(modifieditems);
                    }
                    if (c.isOkay2Draw.value == true) {
                      c.isOkay2Draw.refresh();
                    } else {
                      c.isOkay2Draw.value = true;
                    }

                    modifieditems.clear();
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red),
                  ),
                  child: Text("開始製作PDF")), //I18N
            ],
          ),
          Divider(),
          Expanded(
            child: ShowItemsForManipulate(
              declarer: c.currentDeclare,
              onUpdated: (v) {
                modifieditems.clear();
                modifieditems.addAll(v);
              },
            ),
          ),
        ],
      ),
    );
  }
}
