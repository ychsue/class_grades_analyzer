import 'package:get/get.dart';
import '../data/model/id_keys_model.dart';
import '../data/model/course_keys_model.dart';

class IdAndCourseKeysController extends GetxController {
  IdKeysModel ids = ["座號", "姓名"].obs; // I18N
  CourseKeysModel courseKeys =
      {"數學": 100, "自然": 100, "社會": 100, "國文": 100, "英語": 100}.obs; // I18N

  final endRow = "各科平均".obs;

  final ignoredSheets = [
    "進退步統計",
    "TheDiff",
    "charts_data",
    "Lists",
    "temp_in",
  ].obs;
}
