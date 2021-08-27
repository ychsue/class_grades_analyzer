import 'package:class_grades_analyzer/data/model/dimensions/dims_model.dart';
import 'package:class_grades_analyzer/data/model/dimensions/tab_names.dart';
import 'package:class_grades_analyzer/data/model/pair.dart';

class EachCaseModel {
  DimsModel sortIndices = DimsModel();
  // DimsModel visibleIndices = DimsModel();

  TabsEnum main = (TabsEnum.exam);
  TabsEnum x = (TabsEnum.course);
  TabsEnum y = (TabsEnum.student);

  // #region Constructor
  EachCaseModel({required this.main, required this.x, required this.y});

  EachCaseModel.fromJson(Map<String, dynamic> json) {
    this.fromJson(json);
  }

  EachCaseModel.of(EachCaseModel myCase) {
    this.fromJson(myCase.toJson());
  }

  fromJson(Map<String, dynamic> json) {
    this.main = json['main'];
    this.x = json['x'];
    this.y = json['y'];
    this.sortIndices = DimsModel.fromJson(json['sortIndices']);
    // this.visibleIndices = DimsModel.fromJson(json['visibleIndices']);
  }
  // #endregion Constructor

  toSelAll(
      {required TabsEnum axisEnum,
      bool isAll = true,
      void Function()? runAfter}) {
    // final vAxis = visibleIndices.getDimByEnum(axisEnum);
    final sAxis = sortIndices.getDimByEnum(axisEnum);
    // vAxis?.clear();
    // if (isAll) {
    //   vAxis?.addAll(sAxis ?? []);
    // } else if ((sAxis?.length ?? 0) > 0) {
    //   // Keep the first one
    //   vAxis?.add(sAxis![0]);
    // }
    sAxis?.forEach((ele) {
      if (ele is PairModel<dynamic, bool>) {
        ele.t2 = isAll;
      }
    });
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['main'] = this.main;
    data['x'] = this.x;
    data['y'] = this.y;
    data['sortIndices'] = this.sortIndices;
    // data['visibleIndices'] = this.visibleIndices;

    return data;
  }
}
