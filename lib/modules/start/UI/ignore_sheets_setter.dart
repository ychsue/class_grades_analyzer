import 'package:class_grades_analyzer/controllers/id_and_course_keys_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IgnoreSheetsSetter extends StatefulWidget {
  IgnoreSheetsSetter({Key? key}) : super(key: key);

  @override
  _IgnoreSheetsSetterState createState() => _IgnoreSheetsSetterState();
}

class _IgnoreSheetsSetterState extends State<IgnoreSheetsSetter> {
  final controller = Get.find<IdAndCourseKeysController>();
  final _myTextInputController = TextEditingController();
  final _fNode = FocusNode();

  @override
  void dispose() {
    _myTextInputController.dispose();
    _fNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.red[50],
          border: Border.all(),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            theTitle(),
            Divider(),
            listSheetNames(),
            addNewSheetName(),
          ],
        ),
      ),
    );
  }

  Widget theTitle() {
    return Center(
      child: Text("設定忽略的表單名"),
    ); // I18N
  }

  Widget listSheetNames() {
    final data = controller.ignoredSheets;
    return Wrap(
      children: data
          .map((e) => Chip(
                label: Text("$e"),
                onDeleted: () {
                  data.remove(e);
                },
              ))
          .toList(),
    );
  }

  Widget addNewSheetName() {
    final data = controller.ignoredSheets;
    return Center(
      child: TextField(
        focusNode: _fNode,
        decoration: InputDecoration(
          labelText: "新增欲忽略表單名",
          helperText: "逗號代表設定",
        ), // I18N
        onChanged: (v) {
          if (v.length > 1 && (v.endsWith(",") || v.endsWith("，"))) {
            final all = v.substring(0, v.length - 1);

            if (data.contains(all)) data.remove(all);
            data.add(all);
            setState(() {
              _myTextInputController.clear();
              _fNode.unfocus();
              Future.delayed(const Duration(seconds: 0))
                  .then((_) => _fNode.requestFocus());
            });
          }
        },
        controller: _myTextInputController,
      ),
    );
  }
}
