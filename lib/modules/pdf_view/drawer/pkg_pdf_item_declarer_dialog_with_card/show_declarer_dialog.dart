import 'package:class_grades_analyzer/modules/pdf_view/drawer/pkg_pdf_item_declarer_dialog_with_card/UI/switch_show_h_l_avg.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'UI/grade_type_selector.dart';
import 'UI/pdf_item_type_selector.dart';
import 'UI/select_x_or_y_items.dart';
import 'UI/switch_exchange_xy.dart';
import 'pid_controller.dart';

/// Show a Dialog for you to modify your input [itemData]
///
/// The modified data will be sent back through [itemData.callback]
/// More detail, please read [README.md].
///
showDeclarerDialog(BuildContext ctx, PIDData itemData, {required Widget iconX,
    required Widget iconY,
    required void Function(BuildContext ctx) showX,
    required void Function(BuildContext ctx) showY}) {
  final ctrler = Get.put(PIDController());
  ctrler.iniParas(data: itemData);


  showDialog(
    context: ctx,
    builder: (sctx) => FractionallySizedBox(
      widthFactor: 0.8,
      child: Dialog(
        elevation: 8.0,
        child: Obx(
          () => Form(
            child: //Text("tst"),
                Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  flex: 1,
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      SwitchExchangeXY(cExchangeXY: ctrler.exchangeXY),
                      SwitchShowHLA(cShowHLA: ctrler.showHLA),
                      PDFItemTypeSelector(cType: ctrler.type),
                      GradeTypeSelector(cType: ctrler.gType),
                      SelectXorYItems(ctrler, isXorY: SelXorY.x, icon: iconX, onShow: ()=>showX(sctx)),
                      SelectXorYItems(ctrler, isXorY: SelXorY.y, icon: iconY, onShow: ()=>showY(sctx)),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: (ctrler.errormsgX.value != "" ||
                          ctrler.errormsgY.value != "")
                      ? null
                      : () {
                          ctrler.onSubmit();
                          Get.back();
                        },
                  child: Text("修改"),
                ) // I18N
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
