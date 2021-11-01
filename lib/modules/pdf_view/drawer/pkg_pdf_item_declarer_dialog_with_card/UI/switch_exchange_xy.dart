import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Used for setting exchangeXY
/// About Text with Icon, please read
/// [This Article](https://stackoverflow.com/questions/56840994/how-to-show-icon-in-text-widget-in-flutter)
///
class SwitchExchangeXY extends StatelessWidget {
  const SwitchExchangeXY({Key? key, required this.cExchangeXY})
      : super(key: key);
  final RxBool cExchangeXY;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Card(
        elevation: 4.0,
        child: SwitchListTile(
          title: Text.rich(
            TextSpan(
              children: [
                TextSpan(text: "X "),
                WidgetSpan(
                  child: Icon(Icons.swap_horiz),
                  alignment: PlaceholderAlignment.middle,
                ),
                TextSpan(
                  text: " Y",
                )
              ],
            ),
          ),
          value: cExchangeXY.value,
          onChanged: (v) => cExchangeXY.value = v,
        ),
      ),
    );
  }
}
