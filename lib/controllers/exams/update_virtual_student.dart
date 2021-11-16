import 'package:class_grades_analyzer/controllers/exams_controller.dart';
import 'package:class_grades_analyzer/data/model/exams_model.dart';

extension UpdateVStudent on ExamsController {
  updateVirtualStudent(ExamsModel exams) {
    for (var exam in exams.exams) {
      exam.vStudents.initialize();
    }
    return;
  }
}
