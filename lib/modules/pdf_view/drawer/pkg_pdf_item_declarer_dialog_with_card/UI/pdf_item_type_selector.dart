import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../pid_controller.dart';

class PDFItemTypeSelector extends StatelessWidget {
  const PDFItemTypeSelector({Key? key, required this.cType}) : super(key: key);
  final Rx<PdfItemTypeEnum> cType;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("想產生圖形還是表格？"), // I18N
          Divider(),
          Obx(() => Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: RadioListTile<PdfItemTypeEnum>(
                        title: Icon(Icons.table_chart),
                        value: PdfItemTypeEnum.table,
                        groupValue: cType.value,
                        onChanged: (v) =>
                            cType.value = v ?? PdfItemTypeEnum.table),
                  ),
                  Flexible(
                    child: RadioListTile<PdfItemTypeEnum>(
                        title: Icon(Icons.show_chart),
                        value: PdfItemTypeEnum.lineChart,
                        groupValue: cType.value,
                        onChanged: (v) =>
                            cType.value = v ?? PdfItemTypeEnum.table),
                  ),
                  Flexible(
                    child: RadioListTile<PdfItemTypeEnum>(
                        title: Text.rich(TextSpan(children: [
                          WidgetSpan(
                            child: Icon(Icons.table_chart),
                            alignment: PlaceholderAlignment.middle,
                          ),
                          WidgetSpan(
                            alignment: PlaceholderAlignment.middle,
                            child: Icon(Icons.show_chart),
                          ),
                        ])),
                        value: PdfItemTypeEnum.tbl_chart,
                        groupValue: cType.value,
                        onChanged: (v) =>
                            cType.value = v ?? PdfItemTypeEnum.table),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
