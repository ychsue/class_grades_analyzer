import 'package:get/get.dart';
import 'funs/sel_n_2_list.dart';
export 'funs/sel_n_2_list.dart';

class PIDController extends GetxController {
  final exchangeXY = false.obs;
  final showHLA = false.obs;

  final xType = IndDeclarerEnum.asTableView.obs;
  final yType = IndDeclarerEnum.selN.obs;
  final stSelX = "1".obs;
  List<int> nx = [1];
  final stSelY = "1".obs;
  List<int> ny = [1];
  final type = PdfItemTypeEnum.table.obs;
  final gType = GradeOrRankEnum.grade.obs;

  void Function(PIDData)? callback;

  final errormsgX = "".obs;
  final errormsgY = "".obs;
  late Worker listenSelX;
  late Worker listenSelY;

  @override
  void onInit() {
    listenSelX = debounce(stSelX, (cb) {
      try {
        nx = selN2List(cb as String);
        errormsgX.value = "";
      } catch (e) {
        errormsgX.value = (e as dynamic).message;
      }
    });
    listenSelY = debounce(stSelY, (cb) {
      try {
        ny = selN2List(cb as String);
        errormsgY.value = "";
      } catch (e) {
        errormsgY.value = (e as dynamic).message;
      }
    });
    super.onInit();
  }

  @override
  void onClose() {
    listenSelX.dispose();
    listenSelY.dispose();
    super.onClose();
  }

  /// For initializing the parameters
  ///
  void iniParas({required PIDData data}) {
    this.exchangeXY.value = data.exchangeXY;
    this.showHLA.value = data.showHLA;
    this.xType.value = data.xType;
    this.yType.value = data.yType;
    this.stSelX.value = data.stSelX;
    this.stSelY.value = data.stSelY;
    this.type.value = data.type;
    this.gType.value = data.gType;

    this.callback = data.callback;
  }

  /// Communicate with Env
  ///
  void callback2Env() {
    final data = PIDData()
      ..exchangeXY = this.exchangeXY.value
      ..showHLA = this.showHLA.value
      ..xType = this.xType.value
      ..yType = this.yType.value
      ..stSelX = this.stSelX.value
      ..nx = selN2List(this.stSelX.value)
      ..stSelY = this.stSelY.value
      ..ny = selN2List(this.stSelY.value)
      ..type = this.type.value
      ..gType = this.gType.value
      ..callback = this.callback;
    if (this.callback != null) {
      this.callback!(data);
    }
  }

  void onSubmit() {
    // TODO
    if (this.callback != null) {
      callback2Env();
    }
  }
}

enum IndDeclarerEnum { all, selN, asTableView, custom }

enum PdfItemTypeEnum {
  lineChart,
  table,
  tbl_chart,
}

enum GradeOrRankEnum {
  grade,
  rank,
}

class PIDData {
  bool exchangeXY = false;
  bool showHLA = false; //show highest, lowest and average
  var xType = IndDeclarerEnum.asTableView;
  var yType = IndDeclarerEnum.selN;
  var stSelX = "1";
  List<int>? nx;
  var stSelY = "1";
  List<int>? ny;
  var type = PdfItemTypeEnum.table;
  var gType = GradeOrRankEnum.grade;

  void Function(PIDData)? callback;

  PIDData of(PIDData ini) {
    return PIDData()
      ..exchangeXY = this.exchangeXY
      ..showHLA = this.showHLA
      ..xType = this.xType
      ..yType = this.yType
      ..stSelX = this.stSelX
      ..nx = selN2List(this.stSelX)
      ..stSelY = this.stSelY
      ..ny = selN2List(this.stSelY)
      ..type = this.type
      ..gType = this.gType
      ..callback = this.callback;
  }
}
