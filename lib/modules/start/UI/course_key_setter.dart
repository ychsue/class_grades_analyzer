import 'package:class_grades_analyzer/controllers/id_and_course_keys_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CourseKeySetter extends StatefulWidget {
  CourseKeySetter({Key? key}) : super(key: key);

  @override
  _CourseKeySetterState createState() => _CourseKeySetterState();
}

class _CourseKeySetterState extends State<CourseKeySetter> {
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
        margin: EdgeInsets.fromLTRB(8, 1, 8, 1),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.amber[50],
          border: Border.all(),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: ExpansionTile(
          title: theTitle(),
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Divider(),
                listCourses(),
                addNewCourse(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget theTitle() {
    return Center(
      child: Text("設定課目名稱欄位"),
    ); // I18N
  }

  Widget listCourses() {
    final data = controller.courseKeys;
    return Wrap(
      children: data.keys
          .map((e) => Chip(
                label: Text("$e : ${data[e]}%"),
                onDeleted: () {
                  data.remove(e);
                },
              ))
          .toList(),
    );
  }

  Widget addNewCourse() {
    final data = controller.courseKeys;
    return Center(
      child: TextField(
        focusNode: _fNode,
        decoration: InputDecoration(
          labelText: "新增欄位名",
          helperText: "同上，若要宣告成績比重，可使用'*'號，如 English*50 表示只取50%",
        ), // I18N
        onChanged: (v) {
          if (v.length > 1 && (v.endsWith(",") || v.endsWith("，"))) {
            final all = v.substring(0, v.length - 1);
            final iStar = all.indexOf('*');
            final key = all.substring(0, (iStar > 0) ? iStar : all.length);
            final buf =
                (iStar > 0) ? int.tryParse(all.substring(iStar + 1)) : 100;
            final value = buf ?? 100;

            if (data.keys.contains(key)) data.remove(key);
            data.addAll({key: value});
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
