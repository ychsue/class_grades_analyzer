import 'get_exams_async.dart' as g;

/// You need to provide an IdAndCourseKeysController through GetX
/// by `Get.put(IdAndCourseKeysController())` and
/// `Get.find<IdAndCourseKeysController>()`
///
class FromExcelFileApi {
  var getExamsAsync = g.getExamsAsync;
}
