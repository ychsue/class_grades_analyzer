import 'package:class_grades_analyzer/data/model/pdf/main_pdf_declarer.dart';
import 'package:class_grades_analyzer/data/model/pdf/one_pdf_declarer.dart';
import 'package:class_grades_analyzer/modules/pdf_view/drawer/pkg_pdf_item_declarer_dialog_with_card/pdf_item_declare_card.dart';
import 'sifm_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShowItemsForManipulate extends StatelessWidget {
  const ShowItemsForManipulate(
      {Key? key, required this.declarer, required this.onUpdated})
      : super(key: key);
  final Rx<MainPdfDeclarerModel> declarer;
  final void Function(List<OnePdfDeclarerModel> listChildren) onUpdated;

  @override
  Widget build(BuildContext context) {
    final c = Get.put(SIFMController());
    c.updatePkgChildrenFromCodeChildren(declarer.value.children);
    c.listen2Back2CodeChildren(onUpdated);

    return Container(
      child: Obx(
        () => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Text("宣告各圖表的XY設定"), // I18N
                IconButton(
                  onPressed: () {
                    c.addNewItem();
                  },
                  icon: Icon(
                    Icons.add_circle_outline,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
            Expanded(
              child: ReorderableListView(
                  shrinkWrap: true,
                  children: [
                    for (int i = 0; i < c.pkgChildren.length; i++)
                      Stack(
                        key: ValueKey(i),
                        children: [
                          Container(
                            padding: EdgeInsets.only(right: 5),
                            child: PdfItemDeclarerCard(
                              itemData: c.pkgChildren[i],
                            ),
                          ),
                          Positioned(
                            child: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                c.removeItem(i);
                              },
                            ),
                            top: 0,
                            right: 0,
                          )
                        ],
                      )
                  ],
                  onReorder: c.reorderItems),
            ),
          ],
        ),
      ),
    );
  }
}
