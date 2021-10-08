import 'package:class_grades_analyzer/data/model/dimensions/tab_names.dart';
import 'package:class_grades_analyzer/data/model/pdf/ind_declare_enum.dart';
import 'package:class_grades_analyzer/data/model/pdf/one_pdf_declarer.dart';

class MainPdfDeclarerModel {
  late TabsEnum main;

  String headerScript = "\$0"; //$0 means all,
  String bottomScript = "家長簽名："; //I18N

  IndDeclarerEnum indType = IndDeclarerEnum.selN; // 有三種，先只試前兩種：全部與前面幾個
  String stSelN = "1";
  List<int> nStSelN = [1];
  List<OnePdfDeclarerModel> children = [OnePdfDeclarerModel()];

  MainPdfDeclarerModel(
      {required this.main, List<OnePdfDeclarerModel>? children}) {
    if (children != null && children.length > 0) this.children = children;
  }

  MainPdfDeclarerModel.fromJson(Map<String, dynamic> json) {
    this.main = json['main'];
    this.headerScript = json["headerScript"];
    this.bottomScript = json["bottomScript"];

    this.indType = json['indType'];
    this.stSelN = json['n'];
    this.children = json['children'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['main'] = this.main;
    data['indType'] = this.indType;
    data['n'] = this.stSelN;
    data['children'] = this.children;
    data['headerScript'] = this.headerScript;
    data['bottomScript'] = this.bottomScript;

    return data;
  }
}
