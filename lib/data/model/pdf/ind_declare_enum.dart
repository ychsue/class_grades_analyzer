enum IndDeclarerEnum { all, selN, asTableView, custom }

extension IndDeclarerEnumExtension on IndDeclarerEnum {
  static IndDeclarerEnum fromString(String input) {
    final result = IndDeclarerEnum.values.firstWhere(
        (element) => element.toString().contains(input),
        orElse: () => IndDeclarerEnum.all);
    return result;
  }
}
