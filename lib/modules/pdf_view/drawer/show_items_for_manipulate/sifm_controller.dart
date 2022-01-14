import 'dart:async';

import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart' as rx;

import 'package:class_grades_analyzer/data/model/grade_or_rank.dart';
import 'package:class_grades_analyzer/data/model/pdf/ind_declare_enum.dart';
import 'package:class_grades_analyzer/data/model/pdf/one_pdf_declarer.dart';
import 'package:class_grades_analyzer/data/model/pdf/pdf_item_type.dart';

import '../pkg_pdf_item_declarer_dialog_with_card/pid_controller.dart' as pkg;

class SIFMController extends GetxController {
  final RxList<pkg.PIDData> pkgChildren = <pkg.PIDData>[].obs;
  final RxList<OnePdfDeclarerModel> back2CodeChildren =
      <OnePdfDeclarerModel>[].obs;

  final _unsubscribed = StreamController<bool>.broadcast();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    _unsubscribed.add(true);
    _unsubscribed.close();
    super.onClose();
  }

  listen2Back2CodeChildren(
      void Function(List<OnePdfDeclarerModel> listChildren) onUpdated) {
    back2CodeChildren.stream.takeUntil(_unsubscribed.stream).listen((event) {
      onUpdated(event);
    });
  }

  // TODO 目前偷懶，直接重新打造 back2CodeChildren
  void updateBack2CodeChildren() {
    final List<OnePdfDeclarerModel> result = [];
    for (var item in pkgChildren) {
      result.add(OnePdf2PIDData(item.of(item)));
    }
    back2CodeChildren.value = result;
  }

  void updatePkgChildrenFromCodeChildren(
      List<OnePdfDeclarerModel> codeChildren) {
    final List<pkg.PIDData> result = [];
    for (int i0 = 0; i0 < codeChildren.length; i0++) {
      final item = codeChildren[i0];
      item.nx = pkg.selN2List(item.stSelX);
      item.ny = pkg.selN2List(item.stSelY);
      result.add(pkg.PIDData()
        ..exchangeXY = item.exchangeXY
        ..showHLA = item.showHLA
        ..xType = c2pXYType(item.xType)
        ..yType = c2pXYType(item.yType)
        ..stSelX = item.stSelX
        ..nx = item.nx
        ..stSelY = item.stSelY
        ..ny = item.ny
        ..type = c2pType(item.type)
        ..gType = c2pGType(item.gType)
        ..callback = setCallback(i0));
    }
    pkgChildren.value = result;
  }

  /// This function is used for callback from pkg to this code.
  ///
  /// [ind] is the index for [pkgChildren]
  Function(pkg.PIDData) setCallback(int ind) {
    return (data) {
      pkgChildren[ind] = data;
      updateBack2CodeChildren();
    };
  }

  void reorderItems(int iOld, int iNew) {
    pkgChildren.insert(
      iNew,
      pkgChildren[iOld]..callback = setCallback(iNew),
    );
    pkgChildren.removeAt(iOld + ((iNew < iOld) ? 1 : 0));
    updateBack2CodeChildren();
  }

  void addNewItem() {
    final n = pkgChildren.length;
    pkgChildren.add(pkg.PIDData()..callback = setCallback(n));
    updateBack2CodeChildren();
  }

  void removeItem(int rmInd) {
    final n = pkgChildren.length;
    for (var i = rmInd + 1; i < n; i++) {
      pkgChildren[i].callback = setCallback(i - 1);
    }
    pkgChildren.removeAt(rmInd);
    updateBack2CodeChildren();
  }

  // #region Translation between code and package
  //
  //
  pkg.IndDeclarerEnum c2pXYType(IndDeclarerEnum xType) {
    switch (xType) {
      case IndDeclarerEnum.all:
        return pkg.IndDeclarerEnum.all;
      case IndDeclarerEnum.custom:
        return pkg.IndDeclarerEnum.custom;
      case IndDeclarerEnum.selN:
        return pkg.IndDeclarerEnum.selN;
      case IndDeclarerEnum.asTableView:
      default:
        return pkg.IndDeclarerEnum.asTableView;
    }
  }

  IndDeclarerEnum p2cXYType(pkg.IndDeclarerEnum xType) {
    switch (xType) {
      case pkg.IndDeclarerEnum.all:
        return IndDeclarerEnum.all;
      case pkg.IndDeclarerEnum.custom:
        return IndDeclarerEnum.custom;
      case pkg.IndDeclarerEnum.selN:
        return IndDeclarerEnum.selN;
      case pkg.IndDeclarerEnum.asTableView:
      default:
        return IndDeclarerEnum.asTableView;
    }
  }

  pkg.PdfItemTypeEnum c2pType(PdfItemTypeEnum type) {
    switch (type) {
      case PdfItemTypeEnum.lineChart:
        return pkg.PdfItemTypeEnum.lineChart;
      case PdfItemTypeEnum.tbl_chart:
        return pkg.PdfItemTypeEnum.tbl_chart;
      case PdfItemTypeEnum.table:
      default:
        return pkg.PdfItemTypeEnum.table;
    }
  }

  PdfItemTypeEnum p2cType(pkg.PdfItemTypeEnum type) {
    switch (type) {
      case pkg.PdfItemTypeEnum.lineChart:
        return PdfItemTypeEnum.lineChart;
      case pkg.PdfItemTypeEnum.tbl_chart:
        return PdfItemTypeEnum.tbl_chart;
      case pkg.PdfItemTypeEnum.table:
      default:
        return PdfItemTypeEnum.table;
    }
  }

  pkg.GradeOrRankEnum c2pGType(GradeOrRankEnum gType) {
    switch (gType) {
      case GradeOrRankEnum.rank:
        return pkg.GradeOrRankEnum.rank;
      case GradeOrRankEnum.grade:
      default:
        return pkg.GradeOrRankEnum.grade;
    }
  }

  GradeOrRankEnum p2cGType(pkg.GradeOrRankEnum gType) {
    switch (gType) {
      case pkg.GradeOrRankEnum.rank:
        return GradeOrRankEnum.rank;
      case pkg.GradeOrRankEnum.grade:
      default:
        return GradeOrRankEnum.grade;
    }
  }
  //
  //
  // #endregion Translation between code and package

  OnePdfDeclarerModel OnePdf2PIDData(pkg.PIDData of) {
    return OnePdfDeclarerModel()
      ..exchangeXY = of.exchangeXY
      ..showHLA = of.showHLA
      ..xType = p2cXYType(of.xType)
      ..stSelX = of.stSelX
      ..nx = of.nx ?? []
      ..yType = p2cXYType(of.yType)
      ..stSelY = of.stSelY
      ..ny = of.ny ?? []
      ..type = p2cType(of.type)
      ..gType = p2cGType(of.gType);
  }
}
