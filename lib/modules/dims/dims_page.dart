import 'package:class_grades_analyzer/modules/dims/show_tables.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dims_controller.dart';

class DimsPage extends GetView<DimsController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // return Text('Hello');
      final inds = controller.Inds;
      final data = controller.data;
      final axes = controller.axes;
      return (inds == null)
          ? Text("preparing")
          : ShowTables(inds: inds, data: data, axes: axes);
    });
  }
}
