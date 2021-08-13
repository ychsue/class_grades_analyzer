import 'dart:math';

import 'package:excel/excel.dart';

/// Id and Courses Columns
///
class ICKeys {
  Map<String, int> idC = {};
  Map<String, int> courseKeyC = {};
  int? maxHeadRow;
}

/// Find Key Columns
///
ICKeys getKeyColumns(Sheet sheet, List<String> ids, Map<String, int> keyWs) {
  Map<String, int> idC = {};
  Map<String, int> courseKeyC = {};

  int? _maxHeadRow;

  for (int irow = 0; irow < sheet.rows.length; irow++) {
    /// row: for each student
    var row = sheet.rows[irow];
    var hasFoundAllKeys = false;
    for (int icol = 0; icol < row.length; icol++) {
      var item = row[icol];
      var value = (!(item is Data)) ? item : item.value;
      if (value is String) {
        value = value.replaceAll("\n", "").trim();
        if (ids.contains(value)) {
          idC.addAll({value: icol});
          ids.remove(value);
          _maxHeadRow = (_maxHeadRow == null) ? irow : max(irow, _maxHeadRow);
        } else if (keyWs.containsKey(value)) {
          courseKeyC.addAll({value: icol});
          keyWs.remove(value);
          _maxHeadRow = (_maxHeadRow == null) ? irow : max(irow, _maxHeadRow);
        }
      }
      hasFoundAllKeys = (ids.length == 0) && (keyWs.length == 0);
      if (hasFoundAllKeys) break;
    }
    if (hasFoundAllKeys) break;
  }

  var result = ICKeys();
  if (_maxHeadRow == null) return result;

  return result
    ..courseKeyC = courseKeyC
    ..idC = idC
    ..maxHeadRow = _maxHeadRow;
}
