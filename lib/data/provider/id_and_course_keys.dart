import 'package:class_grades_analyzer/data/model/id_keys_model.dart';
import 'package:get_storage/get_storage.dart';
import '../../data/model/course_keys_model.dart';

class IdAndCourseKeysApi {
  static String storageName = "id_course_keys";
  static GetStorage box = GetStorage(storageName);

  static initAsync() async {
    return await GetStorage.init(storageName);
  }

  static IdKeysModel? _ids;
  static CourseKeysModel? _courseKeys;
  static List<String>? _ignoredNames;
  static String? _endRow;

  static readEndRow() {
    final endRow = box.read('endRow');
    if (endRow != null) _endRow = endRow;

    return _endRow;
  }

  static readIds() {
    final ids = box.read<List<dynamic>>('ids');
    if (ids != null) _ids = IdKeysModel.from(ids);

    return _ids;
  }

  static readCourseKeys() {
    final courseKeys = box.read('courseKeys');

    if (courseKeys != null) _courseKeys = CourseKeysModel.from(courseKeys);

    return _courseKeys;
  }

  static readIgnoredNames() {
    final ig = box.read('ignoredSheetNames');

    if (ig != null) _ignoredNames = List<String>.from(ig);

    return _ignoredNames;
  }

  static writeEndRow(String endRow) {
    box.write('endRow', endRow);
    _endRow = endRow;
  }

  static writeIds(IdKeysModel idKeys) {
    box.write('ids', idKeys);
    _ids = idKeys;
  }

  static writeCourseKeys(CourseKeysModel courseKeys) {
    box.write('courseKeys', courseKeys);
    _courseKeys = courseKeys;
  }

  static writeIgnoredSheetNames(List<String> ig) {
    box.write('ignoredSheetNames', ig);
    _ignoredNames = ig;
  }
}
