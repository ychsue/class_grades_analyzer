import 'package:flutter/material.dart';
import 'ind_paras.dart';
import 'ind_sel_type.dart';
import '../pid_controller.dart';
import 'package:get/get.dart';

class SelectXorYItems extends StatelessWidget {
  const SelectXorYItems(this.ctrler, {Key? key, required this.isXorY})
      : super(key: key);
  final PIDController ctrler;
  final SelXorY isXorY;

  @override
  Widget build(BuildContext context) {
    late Rx<IndDeclarerEnum> cType;
    late RxString cStSel;
    late RxString cErrMsg;
    late String stHeader;
    if (isXorY == SelXorY.x) {
      cType = ctrler.xType;
      stHeader = "想選X軸的哪些項目？"; // I18N
      cStSel = ctrler.stSelX;
      cErrMsg = ctrler.errormsgX;
    } else {
      cType = ctrler.yType;
      stHeader = "Y軸想選的項目是？"; // I18N
      cStSel = ctrler.stSelY;
      cErrMsg = ctrler.errormsgY;
    }

    return Card(
      elevation: 4.0,
      child: Obx(
        () => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Text(stHeader),
            ),
            Divider(),
            ...indSelType(cType),
            if (cType.value == IndDeclarerEnum.selN)
              ...indParas(cStSel, cErrMsg),
          ],
        ),
      ),
    );
  }
}

enum SelXorY { x, y }
