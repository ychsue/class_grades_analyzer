typedef CourseKeysModel = Map<String, int>;

extension MyExtensionOnCourseKeysModel on CourseKeysModel {
  void add({required String key, int weight = 100}) {
    this[key] = weight;
  }
}
