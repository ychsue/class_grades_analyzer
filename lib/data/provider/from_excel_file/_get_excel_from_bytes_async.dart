import 'package:excel/excel.dart';

import '_get_a_file_async.dart';

Future<Excel> getExcelFromBytesAsync({List<int>? data}) async {
  // * 1. Get data from a file if data is not provided
  if (data == null) {
    var file = await getAFileAsync();
    data = file?.bytes;
  }

  if (data == null) {
    throw Exception("EXCEPTION: Pick A File or Give me data"); //I18N
  }

  // * 2. Get Excel's data
  var excel = Excel.decodeBytes(data);

  return excel;
}
