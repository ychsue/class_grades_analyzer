import 'dart:async';

import 'package:class_grades_analyzer/modules/doing_sth/doing_sth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DoingSth extends StatefulWidget {
  DoingSth({Key? key}) : super(key: key);

  @override
  _DoingSthState createState() => _DoingSthState();
}

class _DoingSthState extends State<DoingSth> with TickerProviderStateMixin {
  late AnimationController ctrler;
  late DoingSthController ctrGet;

  @override
  void initState() {
    ctrler = AnimationController(vsync: this, duration: Duration(seconds: 1));
    ctrGet = Get.find<DoingSthController>();
    ctrGet.init(ctrler: ctrler, setState: setState);
    super.initState();
  }

  @override
  void dispose() {
    ctrGet.clearAnimation();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(240, 240, 240, 240),
      child: Center(
        child: //Obx(() =>
            Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              value: ctrGet.animation?.value ?? 0.0,
            ),
            Text(
              ctrGet.title.value,
              style: TextStyle(fontSize: 14),
            ),
          ],
        ), //),
      ),
    );
  }
}
