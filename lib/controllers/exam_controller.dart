import 'package:class_grades_analyzer/data/model/exams_model.dart';
import 'package:get/get.dart';

class ExamController extends GetxController {
  Rx<ExamsModel?> exams = (null as ExamsModel).obs;
}
