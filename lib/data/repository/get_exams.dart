import 'package:class_grades_analyzer/data/model/exams_model.dart';
import '../provider/from_excel_file/index.dart';

class GetExamsRepository {
  final FromExcelFileApi api;

  GetExamsRepository(this.api);

  Future<ExamsModel> getExamsAsync() async {
    return await api.getExamsAsync();
  }

  updateExamsAsync(ExamsModel exams) {
    // TODO
  }
}
