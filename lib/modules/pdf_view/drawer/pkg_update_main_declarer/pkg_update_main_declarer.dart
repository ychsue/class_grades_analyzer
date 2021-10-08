import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'UI/ind_paras.dart';
import 'UI/ind_sel_type.dart';
import 'UI/head_n_tail.dart';
import 'umd_controller.dart';
export 'umd_controller.dart';
export 'funs/sel_n_2_list.dart';

/// Check [README.md] to see how to use this package.
///
UMDController pkgUpdateMainDeclarer(BuildContext context) {
  final c = Get.put(UMDController());

  // BuildContext? dialogCtx;
  showDialog(
    context: context,
    builder: (ctx) {
      // dialogCtx = ctx;
      return Dialog(
        child: Form(
          child: Obx(() => ListView(
                shrinkWrap: true,
                children: [
                  ...headNTail(c),
                  Divider(),
                  ...indSelType(c),
                  Divider(),
                  ...indParas(c),
                  ElevatedButton(
                      onPressed: (c.selErrorMsg.value != "")
                          ? null
                          : () {
                              c.refresh2Env();
                              Get.back();
                              // Navigator.pop(dialogCtx!);
                            },
                      child: Text("確定")), // I18N
                ],
              )),
        ),
      );
    },
  ).then((value) {
    c.canDispose = true;
  });
  return c;
}
