import 'package:get/get.dart';
import '../data/model/id_keys_model.dart';
import '../data/model/grade_keys_model.dart';

class IdAndGradeKeysController extends GetxController {
// final IdAndGradeKeysRepository repository;
// IdAndGradeKeysController(this.repository);

  IdKeysModel ids = ["座號", "姓名"].obs;
  GradeKeysModel gradeKeys =
      {"數學": 100, "自然": 100, "社會": 100, "國文": 100, "英語": 100}.obs;
}
