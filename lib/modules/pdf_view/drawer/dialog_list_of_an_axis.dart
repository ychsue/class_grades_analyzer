import 'package:class_grades_analyzer/data/model/pair.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

showListOfAnAxisDialog(
    {required BuildContext ctx, required Widget icon, List<PairModel>? data}) {
  showDialog(
    context: ctx,
    builder: (ctx2) =>
        // Get.dialog(
        // Scaffold(
        //   body:
        SizedBox(
      height: 800,
      width: 800,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              color: const Color.fromARGB(100, 100, 100, 100),
            ),
          ),
          Center(
            child: Container(
              color: Colors.white,
              child: DialogListOfAnAxis(icon: icon, data: data),
            ),
          )
        ],
      ),
    ),
    // ),
  );
}

class DialogListOfAnAxis extends StatelessWidget {
  const DialogListOfAnAxis({Key? key, required this.icon, this.data})
      : super(key: key);
  final Widget icon;
  final List<PairModel>? data;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 400),
      child: listOfData(),
    );
  }

  Widget listOfData() {
    return Column(
      children: [
        Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              icon,
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("(${data?.length})"),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            shrinkWrap: true,
            children: List.generate(
              data?.length ?? 0,
              (index) => Card(
                child: ListTile(
                  leading: Text("${index + 1}"),
                  title: Text("${data?[index].t1.toString()}"),
                ),
              ),
            ),
          ),
        ),
      ],
      mainAxisSize: MainAxisSize.min,
    );
  }
}
