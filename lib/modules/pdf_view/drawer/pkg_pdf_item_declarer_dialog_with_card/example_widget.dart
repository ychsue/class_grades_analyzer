import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'pdf_item_declare_card.dart';
import 'pid_controller.dart';

class ExampleWidget extends StatelessWidget {
  const ExampleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RxList<PIDData> datas = [
      PIDData()
        ..exchangeXY = true
        ..stSelX = '2~5'
        ..xType = IndDeclarerEnum.selN,
      PIDData(),
    ].obs;

    for (var i = 0; i < datas.length; i++) {
      final item = datas[i];
      item
        ..callback = (data) {
          datas[i] = data;
        };
    }

    return Obx(
      () => ListView(
        children: [
          PdfItemDeclarerCard(
            itemData: datas[0],
            iconX: Icon(Icons.text_snippet),
            iconY: Icon(Icons.text_snippet),
            showX: (c) => null,
            showY: (c) => null,
          ),
          PdfItemDeclarerCard(
            itemData: datas[1],
            iconX: Icon(Icons.text_snippet),
            iconY: Icon(Icons.text_snippet),
            showX: (c) => null,
            showY: (c) => null,
          ),
        ],
      ),
    );
  }
}
