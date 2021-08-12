import 'package:class_grades_analyzer/modules/doing_sth/doing_sth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TestHome extends StatelessWidget {
  const TestHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final c = Get.find<DoingSthController>();
    return Container(
      child: Center(
        child: ElevatedButton(
          child: Text("Show Doing Something"),
          onPressed: () async {
            c.start(0, 0.2);
            await Future.delayed(Duration(seconds: 3));
            c.start(0.2, 0.7);
            await Future.delayed(Duration(seconds: 2));
            c.start(0.7, 1.0);
            await Future.delayed(Duration(seconds: 2));
            c.done();
          },
        ),
      ),
    );
  }
}
