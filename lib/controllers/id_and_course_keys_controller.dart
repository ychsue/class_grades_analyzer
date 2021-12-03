import 'package:class_grades_analyzer/data/provider/id_and_course_keys.dart';
import 'package:get/get.dart';

class IdAndCourseKeysController extends GetxController {
  final ids = ["座號", "姓名"].obs; // I18N
  final courseKeys =
      {"數學": 100, "自然": 100, "社會": 100, "國文": 100, "英語": 100}.obs; // I18N

  final endRow = "各科平均".obs;

  final ignoredSheets = [
    "進退步統計",
    "TheDiff",
    "charts_data",
    "Lists",
    "temp_in",
  ].obs;

  updateFromGetStorage() {
    final idsBuf = IdAndCourseKeysApi.readIds();
    final courseKeysBuf = IdAndCourseKeysApi.readCourseKeys();
    final ig = IdAndCourseKeysApi.readIgnoredNames();
    final endRowBuf = IdAndCourseKeysApi.readEndRow();
    if (idsBuf != null) ids.value = idsBuf;
    if (courseKeysBuf != null) courseKeys.value = courseKeysBuf;
    if (ig != null) ignoredSheets.value = ig;
    if (endRowBuf != null) endRow.value = endRowBuf;
  }

  write2GetStorage() {
    IdAndCourseKeysApi.writeIds(ids);
    IdAndCourseKeysApi.writeCourseKeys(courseKeys);
    IdAndCourseKeysApi.writeIgnoredSheetNames(ignoredSheets);
    IdAndCourseKeysApi.writeEndRow(endRow.value);
  }
}
