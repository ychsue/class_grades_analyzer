import 'package:class_grades_analyzer/data/model/grade_or_rank.dart';
import 'package:class_grades_analyzer/data/model/pdf/ind_declare_enum.dart';
import 'package:class_grades_analyzer/data/model/pdf/pdf_item_type.dart';
export 'fun_for_one_pdf_declarer.dart';

class OnePdfDeclarerModel {
  bool exchangeXY = false;
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
    this.xType = json['xType'];
    this.nx = json['nx'];
    this.yType = json['yType'];
    this.ny = json['ny'];
    this.type = json['type'];
    this.gType = json['gType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['exchangeXY'] = this.exchangeXY;
    data['xType'] = this.xType;
    data['nx'] = this.nx;
    data['yType'] = this.yType;
    data['ny'] = this.ny;
    data['type'] = this.type;
    data['gType'] = this.gType;
    return data;
  }
}
