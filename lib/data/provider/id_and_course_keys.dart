import 'package:class_grades_analyzer/data/model/id_keys_model.dart';
import 'package:get_storage/get_storage.dart';

class IdAndCourseKeysApi {
  static String storageName = "id_course_keys";
  static GetStorage box = GetStorage(storageName);

  static initAsync() async {
    return await GetStorage.init(storageName);
  }

  static IdKeysModel? _ids;

  readIds() {
    _ids ??= box.read<IdKeysModel>('ids');

    return _ids;
  }

  writeIds(IdKeysModel idKeys) {
    box.write('ids', idKeys);
    _ids = idKeys;
  }
}
