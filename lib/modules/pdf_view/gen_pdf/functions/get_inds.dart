import 'package:class_grades_analyzer/data/model/pair.dart';
import 'package:class_grades_analyzer/data/model/pdf/ind_declare_enum.dart';

List<dynamic> getInds({
  required IndDeclarerEnum indType,
  required List<PairModel<dynamic, bool>> viewInds,
  int n = 1,
}) {
  late List<dynamic> inds;

  switch (indType) {
    case IndDeclarerEnum.all:
      inds = viewInds.map((e) => e.t1).toList();
      break;
    case IndDeclarerEnum.asTableView:
      inds = viewInds.where((e) => e.t2).map((e) => e.t1).toList();
      break;
    case IndDeclarerEnum.firstN:
      inds = viewInds.sublist(0, n).map((e) => e.t1).toList();
      break;
    case IndDeclarerEnum.custom:
      // TODO
      break;
    default:
  }

  return inds;
}
