import 'package:class_grades_analyzer/controllers/my_global_controller.dart';
import 'package:class_grades_analyzer/data/model/dimensions/tab_names.dart';
import 'package:class_grades_analyzer/data/model/pdf/one_pdf_declarer.dart';
import 'package:class_grades_analyzer/modules/pdf_view/drawer/dialog_list_of_an_axis.dart';
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
    final nPerPage = 0.obs;
    nPerPage.value =
        c.currentDeclare.value.nPerPage; // Just used for asking for rerendering

    // #region For showing list of each axis
    final tabMain = MyGlobalController.Tabs[TabNames.name(axes.value.main)] ??
        Placeholder();
    final tabX = MyGlobalController.Tabs[TabNames.name(axes.value.x)] ??
        Placeholder();
    final tabY = MyGlobalController.Tabs[TabNames.name(axes.value.y)] ??
        Placeholder();
    late void Function(BuildContext ctx) showMain = (BuildContext ctx) => showListOfAnAxisDialog(ctx: ctx, icon: tabMain, data: gC.allAxes.getDimByEnum(axes.value.main));
    late void Function(BuildContext ctx) showX = (BuildContext ctx) => showListOfAnAxisDialog(
        ctx: ctx,
        icon: tabX,
        data: gC.allAxes.getDimByEnum(axes.value.x));
    late void Function(BuildContext ctx) showY = (BuildContext ctx) => showListOfAnAxisDialog(
        ctx: ctx,
        icon: tabY,
        data: gC.allAxes.getDimByEnum(axes.value.y));
    // #endregion  For showing list of each axis
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
            child: //Obx(() => 
            Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("主要："), //I18N
                        tabMain,
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("X軸："), //I18N
                        tabX,
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("Y軸："), //I18N
                        tabY,
                      ],
                    ),
                  ],
                ),
                //),
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
                    icon: tabMain,
                    onShow: ()=>showMain(context)
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("設定 "), //I18N
                    tabMain,
                    Text(" 裏要顯示者"), //I18N
                  ],
                )),
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Obx(
                () => DropdownButton<int>(
                  value: nPerPage.value,
                  items: [1, 2, 3, 4]
                      .map((e) => DropdownMenuItem(
                            child: Text("$e"),
                            value: e,
                          ))
                      .toList(),
                  onChanged: (v) {
                    nPerPage.value = v ?? 1;
                    c.currentDeclare.value.nPerPage = nPerPage.value;
                  },
                ),
              ),

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
                child: Text("開始製作PDF"),
              ), //I18N
            ],
          ),
          Divider(),
          Expanded(
            child: ShowItemsForManipulate(
              declarer: c.currentDeclare,
              iconX: tabX,
              iconY: tabY,
              showX: showX,
              showY: showY,
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
