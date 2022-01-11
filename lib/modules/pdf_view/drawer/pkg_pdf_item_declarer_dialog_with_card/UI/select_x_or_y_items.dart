import 'package:flutter/material.dart';
import 'ind_paras.dart';
import 'ind_sel_type.dart';
import '../pid_controller.dart';
import 'package:get/get.dart';

class SelectXorYItems extends StatelessWidget {
  const SelectXorYItems(this.ctrler,
      {Key? key,
      required this.isXorY,
      required this.icon,
      required this.onShow})
      : super(key: key);
  final PIDController ctrler;
  final SelXorY isXorY;

  final Widget icon;
  final void Function() onShow;

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
              child: ElevatedButton(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(stHeader),
                    icon,
                  ],
                ),
                onPressed: onShow,
              ),
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
