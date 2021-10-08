import 'package:get/get.dart';
import 'funs/sel_n_2_list.dart';

class UMDController extends GetxController {
  final headerScript = "".obs;
  final bottomScript = "".obs;
  final indType = IndDeclarerEnum.all.obs;
  final stSelN = "1".obs;
  final selErrorMsg = "".obs;

  final toEnv = ToEnv().obs;

  late Worker stSelNWorker;
  bool canDispose = false;

  @override
  void onInit() {
    stSelNWorker = debounce(stSelN, (cb) {
      try {
        selN2List(stSelN.value);
        selErrorMsg.value = "";
      } catch (e) {
        selErrorMsg.value = (e as dynamic).message;
      }
    });
    super.onInit();
  }

  void iniParas(
      String headerScript, String bottomScript, IndDeclarerEnum indType,
      [String? stSelN]) {
    this.headerScript.value = headerScript;
    this.bottomScript.value = bottomScript;
    this.indType.value = indType;
    if (stSelN != null) this.stSelN.value = stSelN;
  }

  void refresh2Env() {
    toEnv.value = ToEnv(
      headerScript: headerScript.value,
      bottomScript: bottomScript.value,
      indType: indType.value,
      stSelN: stSelN.value,
      nStSelN: selN2List(stSelN.value),
    );
  }

  @override
  void onClose() {
    stSelNWorker.dispose();
    super.onClose();
  }
}

class ToEnv {
  String? headerScript;
  String? bottomScript;
  IndDeclarerEnum? indType;
  String? stSelN;
  List<int>? nStSelN;
  // bool isClosing = false;
  ToEnv(
      {this.headerScript,
      this.bottomScript,
      this.indType,
      this.stSelN,
      this.nStSelN});
}

enum IndDeclarerEnum { all, selN, asTableView, custom }
