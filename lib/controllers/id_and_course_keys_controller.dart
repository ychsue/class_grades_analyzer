import 'package:class_grades_analyzer/controllers/global_var/update_v_course_names.dart';
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

  final avgName = "各科平均".obs;
  final sumName = "總分".obs;

  final avgAllName = "平均".obs;
  final highestName = "最高分".obs;
  final lowestName = "最低分".obs;

  updateFromGetStorage() {
    final idsBuf = IdAndCourseKeysApi.readIds();
    final courseKeysBuf = IdAndCourseKeysApi.readCourseKeys();
    final ig = IdAndCourseKeysApi.readIgnoredNames();
    final endRowBuf = IdAndCourseKeysApi.readEndRow();

    final avgNameBuf = IdAndCourseKeysApi.readAvgName();
    final sumNameBuf = IdAndCourseKeysApi.readSumName();
    if (avgNameBuf != null) avgName.value = avgNameBuf;
    if (sumNameBuf != null) sumName.value = sumNameBuf;

    // #region highest, lowest, and average
    final avgAllNameBuf = IdAndCourseKeysApi.readAvgAllName();
    final highestNameBuf = IdAndCourseKeysApi.readHighestName();
    final lowestNameBuf = IdAndCourseKeysApi.readLowestName();
    if (avgAllNameBuf != null) avgAllName.value = avgAllNameBuf;
    if (highestNameBuf != null) highestName.value = highestNameBuf;
    if (lowestNameBuf != null) lowestName.value = lowestNameBuf;
    // #endregion highest, lowest, and average

    if (idsBuf != null) ids.value = idsBuf;
    if (courseKeysBuf != null) courseKeys.value = courseKeysBuf;
    if (ig != null) ignoredSheets.value = ig;
    if (endRowBuf != null) endRow.value = endRowBuf;
    updateVCourseNames();
  }

  write2GetStorage() {
    IdAndCourseKeysApi.writeIds(ids);
    IdAndCourseKeysApi.writeCourseKeys(courseKeys);
    IdAndCourseKeysApi.writeIgnoredSheetNames(ignoredSheets);
    IdAndCourseKeysApi.writeEndRow(endRow.value);
    IdAndCourseKeysApi.writeAvgName(avgName.value);
    IdAndCourseKeysApi.writeSumName(sumName.value);
    IdAndCourseKeysApi.writeAvgAllName(avgAllName.value);
    IdAndCourseKeysApi.writeHighestName(highestName.value);
    IdAndCourseKeysApi.writeLowestName(lowestName.value);
  }
}
