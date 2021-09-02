import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dims_controller.dart';

class DimsPage extends GetView<DimsController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => Text(controller.gC.tab.value.toString()));
  }
}
