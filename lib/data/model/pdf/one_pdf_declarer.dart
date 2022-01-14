import 'package:class_grades_analyzer/data/model/grade_or_rank.dart';
import 'package:class_grades_analyzer/data/model/pdf/ind_declare_enum.dart';
import 'package:class_grades_analyzer/data/model/pdf/pdf_item_type.dart';
export 'fun_for_one_pdf_declarer.dart';

class OnePdfDeclarerModel {
  bool exchangeXY = false;
  bool showHLA = false;
  IndDeclarerEnum xType = IndDeclarerEnum.asTableView;
  String stSelX = "1";
  List<int> nx = [1];
  IndDeclarerEnum yType = IndDeclarerEnum.selN;
  String stSelY = "1";
  List<int> ny = [1];

  PdfItemTypeEnum type = PdfItemTypeEnum.table;

  GradeOrRankEnum gType = GradeOrRankEnum.grade;

  OnePdfDeclarerModel();

  OnePdfDeclarerModel of(OnePdfDeclarerModel input) {
    return OnePdfDeclarerModel()
      ..exchangeXY = this.exchangeXY
      ..showHLA = this.showHLA
      ..xType = this.xType
      ..stSelX = this.stSelX
      ..nx = this.nx
      ..yType = this.yType
      ..stSelY = this.stSelY
      ..ny = this.ny
      ..type = this.type
      ..gType = this.gType;
  }

  OnePdfDeclarerModel.fromJson(Map<String, dynamic> json) {
    this.exchangeXY = json['exchangeXY'];
    this.showHLA = json['showHLA'];
    this.xType = IndDeclarerEnumExtension.fromString(json['xType']);
    this.stSelX = json['stSelX'];
    this.yType = IndDeclarerEnumExtension.fromString(json['yType']);
    this.stSelY = json['stSelY'];
    this.type = PdfItemTypeEnumExtension.fromString(json['type']);
    this.gType = GradeOrRankEnumExtension.fromString(json['gType']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['exchangeXY'] = this.exchangeXY;
    data['showHLA'] = this.showHLA;
    data['xType'] = this.xType.toString();
    data['stSelX'] = this.stSelX;
    data['yType'] = this.yType.toString();
    data['stSelY'] = this.stSelY;
    data['type'] = this.type.toString();
    data['gType'] = this.gType.toString();
    return data;
  }
}
