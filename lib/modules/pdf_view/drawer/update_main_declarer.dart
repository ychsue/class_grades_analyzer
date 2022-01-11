import 'package:class_grades_analyzer/data/model/pdf/ind_declare_enum.dart';
import 'package:class_grades_analyzer/data/model/pdf/main_pdf_declarer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'pkg_update_main_declarer/pkg_update_main_declarer.dart' as pkg;

void updateMainDeclarer(
    BuildContext context, Rx<MainPdfDeclarerModel> currentDeclare,
    {required Widget icon, required void Function() onShow}) {
  // 1. show the dialog
  final c = pkg.pkgUpdateMainDeclarer(context, icon: icon, onShow: onShow);
  // 2. initialize this dialog
  String headerScript = currentDeclare.value.headerScript;
  String bottomScript = currentDeclare.value.bottomScript;
  pkg.IndDeclarerEnum indType = _env2PkgIndType(currentDeclare.value.indType);
  String stSelN = currentDeclare.value.stSelN;
  c.iniParas(headerScript, bottomScript, indType, stSelN);
  // 3. listen to response
  late Worker listenPkg;
  listenPkg = debounce(
    c.toEnv,
    (v) {
      _pkg2Env(c.toEnv.value, currentDeclare.value);
      if (c.canDispose) listenPkg.dispose();
    },
    time: const Duration(seconds: 0),
  );
}

void _pkg2Env(pkg.ToEnv toEnv, MainPdfDeclarerModel declarer) {
  declarer.headerScript = toEnv.headerScript ?? "";
  declarer.bottomScript = toEnv.bottomScript ?? "";
  declarer.stSelN = toEnv.stSelN ?? "";
  declarer.nStSelN = toEnv.nStSelN ?? [1];
  declarer.indType = _pkg2EnvIndType(toEnv.indType);
}

IndDeclarerEnum _pkg2EnvIndType(pkg.IndDeclarerEnum? indType) {
  switch (indType) {
    case pkg.IndDeclarerEnum.all:
      return IndDeclarerEnum.all;
    case pkg.IndDeclarerEnum.asTableView:
      return IndDeclarerEnum.asTableView;
    case pkg.IndDeclarerEnum.custom:
      return IndDeclarerEnum.custom;
    case pkg.IndDeclarerEnum.selN:
      return IndDeclarerEnum.selN;
    default:
      return IndDeclarerEnum.all;
  }
}

pkg.IndDeclarerEnum _env2PkgIndType(IndDeclarerEnum input) {
  switch (input) {
    case IndDeclarerEnum.all:
      return pkg.IndDeclarerEnum.all;
    case IndDeclarerEnum.asTableView:
      return pkg.IndDeclarerEnum.asTableView;
    case IndDeclarerEnum.selN:
      return pkg.IndDeclarerEnum.selN;
    case IndDeclarerEnum.custom:
      return pkg.IndDeclarerEnum.custom;
    default:
      return pkg.IndDeclarerEnum.all;
  }
}
