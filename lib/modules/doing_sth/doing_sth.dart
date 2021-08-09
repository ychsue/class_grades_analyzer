import 'dart:async';

import 'package:class_grades_analyzer/modules/doing_sth/doing_sth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

class DoingSth extends StatefulWidget {
  DoingSth({Key? key}) : super(key: key);

  @override
  _DoingSthState createState() => _DoingSthState();
}

class _DoingSthState extends State<DoingSth> with TickerProviderStateMixin {
  late AnimationController ctrler;
  late DoingSthController ctrGet;
  Animation<double>? animation;
  final _unsubscribe = StreamController<bool>();

  void _setState() {
    setState(() {});
  }

  void _renewATween(double end) {
    ctrler.reset();
    animation?.removeListener(_setState);
    animation = Tween(begin: ctrGet.previousProgress.value, end: end)
        .animate(ctrler)
          ..addListener(_setState);
    ctrler.forward();
  }

  @override
  void initState() {
    ctrler = AnimationController(vsync: this, duration: Duration(seconds: 1));
    ctrGet = Get.find<DoingSthController>();
    _renewATween(ctrGet.progress.value);
    ctrGet.progress.stream.takeUntil(_unsubscribe.stream).listen((v) {
      _renewATween(v);
    });
    super.initState();
  }

  @override
  void dispose() {
    _unsubscribe.add(true);
    ctrler.stop();
    ctrler.dispose();
    _unsubscribe.close();
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
              value: animation?.value ?? 0.0,
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
