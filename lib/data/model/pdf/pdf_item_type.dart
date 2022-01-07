enum PdfItemTypeEnum {
  lineChart,
  table,
  tbl_chart,
}

extension PdfItemTypeEnumExtension on PdfItemTypeEnum {
  static PdfItemTypeEnum fromString(String input) {
    PdfItemTypeEnum result = PdfItemTypeEnum.values.firstWhere(
      (element) => element.toString().contains(input),
      orElse: () => PdfItemTypeEnum.tbl_chart,
    );
    return result;
  }

  // String get value {
  //   switch (this) {
  //     case PdfItemTypeEnum.lineChart:
  //       return "lineChart";
  //     case PdfItemTypeEnum.table:
  //       return "table";
  //     default:
  //       return "tbl_chart";
  //   }
  // }
}
