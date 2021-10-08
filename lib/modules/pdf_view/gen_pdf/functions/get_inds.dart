import 'package:class_grades_analyzer/data/model/pair.dart';
import 'package:class_grades_analyzer/data/model/pdf/ind_declare_enum.dart';

List<dynamic> getInds({
  required IndDeclarerEnum indType,
  required List<PairModel<dynamic, bool>> viewInds,
  List<int> nStSelN = const [1],
}) {
  late List<dynamic> inds;

  switch (indType) {
    case IndDeclarerEnum.all:
      inds = viewInds.map((e) => e.t1).toList();
      break;
    case IndDeclarerEnum.asTableView:
      inds = viewInds.where((e) => e.t2).map((e) => e.t1).toList();
      break;
    case IndDeclarerEnum.selN:
      inds = [];
      for (var iN in nStSelN) {
        inds.add(viewInds[iN - 1].t1);
      }
      break;
    case IndDeclarerEnum.custom:
      // TODO
      break;
    default:
  }

  return inds;
}
