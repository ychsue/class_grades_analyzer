typedef GradeKeysModel = Map<String, int>;

extension MyExtensionOnGradeKeysModel on GradeKeysModel {
  void add({required String key, int weight = 100}) {
    this[key] = weight;
  }
}
