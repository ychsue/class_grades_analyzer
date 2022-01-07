import 'package:class_grades_analyzer/data/model/dimensions/tab_names.dart';
import 'package:class_grades_analyzer/data/model/pdf/ind_declare_enum.dart';
import 'package:class_grades_analyzer/data/model/pdf/main_pdf_declarer.dart';
import 'package:class_grades_analyzer/data/model/pdf/one_pdf_declarer.dart';
import 'package:class_grades_analyzer/data/model/pdf/pdf_item_type.dart';
import 'package:class_grades_analyzer/data/provider/for_pdf_declarer.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() {
  const key = 'pdf_declarer';
  late GetStorage box;
  late List<Rx<MainPdfDeclarerModel>> data;

  setUp(() {
    data = <Rx<MainPdfDeclarerModel>>[
      (MainPdfDeclarerModel(main: TabsEnum.exam)
            ..headerScript = "\$1班 第\$2學期 第\$3次月考"
            ..children = [OnePdfDeclarerModel()..yType = IndDeclarerEnum.all])
          .obs, //I18N
      (MainPdfDeclarerModel(main: TabsEnum.student)
            ..headerScript = "座號：\$1，姓名：\$2"
            ..children = [
              OnePdfDeclarerModel()
                ..type = PdfItemTypeEnum.tbl_chart
                ..stSelY = "1~2"
                ..ny = [1, 2]
            ]
            ..indType = IndDeclarerEnum.all)
          .obs,
      (MainPdfDeclarerModel(main: TabsEnum.course)
            ..indType = IndDeclarerEnum.all
            ..children = [OnePdfDeclarerModel()..yType = IndDeclarerEnum.all])
          .obs,
    ];
  });

  test('write and load', () async {
    await ForPDFDeclarer.write(data);
    print('The data has been written into GetStorage');
    final rValue = ForPDFDeclarer.load();
    print('load it from GetStorage');
    print(rValue.toString());
  });
}
