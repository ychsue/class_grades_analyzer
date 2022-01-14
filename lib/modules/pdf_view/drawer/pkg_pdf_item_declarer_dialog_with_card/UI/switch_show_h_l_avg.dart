import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Used for setting exchangeXY
/// About Text with Icon, please read
/// [This Article](https://stackoverflow.com/questions/56840994/how-to-show-icon-in-text-widget-in-flutter)
///
class SwitchShowHLA extends StatelessWidget {
  const SwitchShowHLA({Key? key, required this.cShowHLA}) : super(key: key);
  final RxBool cShowHLA;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Card(
        elevation: 4.0,
        child: SwitchListTile(
          title: Text("若能的話，顯示第一列的最高、最低與平均"), //I18N

          value: cShowHLA.value,
          onChanged: (v) => cShowHLA.value = v,
        ),
      ),
    );
  }
}
