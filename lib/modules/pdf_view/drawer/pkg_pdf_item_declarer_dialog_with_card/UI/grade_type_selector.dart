import 'package:flutter/material.dart';
import '../pid_controller.dart';
import 'package:get/get.dart';

class GradeTypeSelector extends StatelessWidget {
  const GradeTypeSelector({Key? key, required this.cType}) : super(key: key);
  final Rx<GradeOrRankEnum> cType;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("想看成績還是名次？"), // I18N
          Divider(),
          Obx(() => Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: RadioListTile<GradeOrRankEnum>(
                        title: Text("成績"), // I18N
                        value: GradeOrRankEnum.grade,
                        groupValue: cType.value,
                        onChanged: (v) =>
                            cType.value = v ?? GradeOrRankEnum.grade),
                  ),
                  Flexible(
                    child: RadioListTile<GradeOrRankEnum>(
                        title: Text("名次"), // I18N
                        value: GradeOrRankEnum.rank,
                        groupValue: cType.value,
                        onChanged: (v) =>
                            cType.value = v ?? GradeOrRankEnum.grade),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
