import 'package:class_grades_analyzer/controllers/id_and_course_keys_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StudentIDSetter extends StatefulWidget {
  StudentIDSetter({Key? key}) : super(key: key);

  @override
  _StudentIDSetterState createState() => _StudentIDSetterState();
}

class _StudentIDSetterState extends State<StudentIDSetter> {
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
          color: Colors.cyan[100],
          border: Border.all(),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            theTitle(),
            Divider(),
            listOfIds(),
            inputIds(),
          ],
        ),
      ),
    );
  }

  Widget inputIds() {
    return Center(
      child: TextField(
        focusNode: _fNode,
        decoration: InputDecoration(
          labelText: "新增欄位名",
          helperText: "鍵入逗號即新增一欄位",
        ), // I18N
        onChanged: (v) {
          if (v.length > 1 && (v.endsWith(",") || v.endsWith("，"))) {
            final vNew = v.substring(0, v.length - 1);
            if (controller.ids.contains(vNew)) controller.ids.remove(vNew);
            controller.ids.add(vNew);
            setState(() {
              _myTextInputController.clear();
              _fNode.unfocus(); // 讓中文輸入不至於遺留到下一次輸入。
              Future.delayed(const Duration(seconds: 0))
                  .then((_) => _fNode.requestFocus());
            });
          }
        },
        controller: _myTextInputController,
      ),
    );
  }

  Widget listOfIds() {
    return Wrap(
      children: [
        ...controller.ids.map(
          (e) => Container(
            margin: EdgeInsets.all(8),
            child: Chip(
              label: Text("$e"),
              onDeleted: () {
                controller.ids.remove(e);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget theTitle() {
    return Center(
      child: Text("用來辨識學生的欄位值"), // I18N
    );
  }
}
