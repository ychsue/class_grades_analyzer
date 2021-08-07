import 'package:file_picker/file_picker.dart';

Future<PlatformFile?> getAFileAsync() async {
  var result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['xlsx', 'xlsm'],
  );

  return result?.files.first;
}
