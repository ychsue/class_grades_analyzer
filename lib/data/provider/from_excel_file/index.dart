import 'get_exams_async.dart' as g;

/// You need to provide an IdAndGradeKeysController through GetX
/// by `Get.put(IdAndGradeKeysController())` and
/// `Get.find<IdAndGradeKeysController>()`
///
class FromExcelFileApi {
  var getExamsAsync = g.getExamsAsync;
}
