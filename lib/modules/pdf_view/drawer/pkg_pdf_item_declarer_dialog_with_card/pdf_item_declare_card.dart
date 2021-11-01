import 'package:flutter/material.dart';
import 'pid_controller.dart';
import 'show_declarer_dialog.dart';

/// Show a [Card] to outline the input [itemData]
///
/// If you want to modify its data, clicking the button and the modified data will be sent back through [itemData.callback]
/// More detail, please read [README.md].
///
class PdfItemDeclarerCard extends StatelessWidget {
  const PdfItemDeclarerCard({Key? key, required this.itemData})
      : super(key: key);

  final PIDData itemData;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      child: Column(
        children: [
          Text("圖表宣告：" + pIDType2String(itemData.type)), //I18N
          Divider(),
          Wrap(
            spacing: 10,
            children: [
              if (itemData.exchangeXY) Text("🔹XY交換顯示"), //I18N
              Text("🔹X選取：" +
                  xyType2String(itemData.xType, itemData.stSelX)), //I18N
              Text("🔹Y選取：" +
                  xyType2String(itemData.yType, itemData.stSelY)), //I18N
              Text("🔹取值：" + gType2String(itemData.gType)), //I18N
            ],
          ),
          ElevatedButton(
            onPressed: () {
              showDeclarerDialog(context, itemData);
            },
            child: Text("編輯"), //I18N
          ),
        ],
      ),
    );
  }
}

String gType2String(GradeOrRankEnum gType) {
  switch (gType) {
    case GradeOrRankEnum.grade:
      return "各科分數"; // I18N
    case GradeOrRankEnum.rank:
      return "各科名次"; // I18N
    default:
      return "出問題了"; // I18N
  }
}

String pIDType2String(PdfItemTypeEnum type) {
  switch (type) {
    case PdfItemTypeEnum.lineChart:
      return "折線圖"; // I18N
    case PdfItemTypeEnum.table:
      return "表格"; // I18N
    case PdfItemTypeEnum.tbl_chart:
      return "折線圖+表格"; // I18N
    default:
      return "有問題發生"; // I18N
  }
}

String xyType2String(IndDeclarerEnum xType, String stRange) {
  switch (xType) {
    case IndDeclarerEnum.all:
      return "全選"; //I18N
    case IndDeclarerEnum.asTableView:
      return "如前頁"; //I18N
    case IndDeclarerEnum.selN:
      return stRange;
    default:
      return "有問題發生"; //I18N
  }
}
