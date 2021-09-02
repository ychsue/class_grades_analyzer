import 'package:class_grades_analyzer/controllers/my_global_controller.dart';
import 'package:class_grades_analyzer/data/model/dimensions/each_case_model.dart';
import 'package:class_grades_analyzer/data/model/dimensions/tab_names.dart';
import 'package:get/get.dart';

class DimsController extends GetxController {
  Rx<EachCaseModel?> axes = (null).obs;
  late MyGlobalController gC;

  @override
  void onInit() {
    gC = Get.find<MyGlobalController>();
    // TODO: implement onInit
    super.onInit();
  }

  /// Its [data]'s structure is data[main][y][x]
  ///
  List<List<List<dynamic>>> get data {
    var axes = gC.cases.firstWhere((ele) => ele.value.main == gC.tab.value);
    var exams = gC.exams.value;
    var gType = gC.gType.value;

    var main = axes.value.sortIndices
        .getDimByEnum(axes.value.main)
        ?.where((ele) => ele.t2)
        .toList();
    var x = axes.value.sortIndices
        .getDimByEnum(axes.value.x)
        ?.where((ele) => ele.t2)
        .toList();
    var y = axes.value.sortIndices
        .getDimByEnum(axes.value.y)
        ?.where((ele) => ele.t2)
        .toList();

    List<List<List<dynamic>>> result = [];
    // * [main], [x] and [y] cannot be empty.
    String examInd = "";
    dynamic studentInd = "";
    String courseInd = "";
    var feedIndices = (TabsEnum indType, dynamic axisInd) {
      switch (indType) {
        case TabsEnum.exam:
          examInd = axisInd;
          break;
        case TabsEnum.student:
          studentInd = axisInd;
          break;
        case TabsEnum.course:
          courseInd = axisInd;
          break;
        default:
          assert(false, "feedIndices' indType does not exist");
      }
    };
    if ((main?.length != 0) && (x?.length != 0) && (y?.length != 0)) {
      List.generate(
        main!.length,
        (imain) {
          feedIndices(axes.value.main, main[imain].t1);
          return List.generate(
            y!.length,
            (iy) {
              feedIndices(axes.value.y, main[iy].t1);
              return List.generate(x!.length, (ix) {
                feedIndices(axes.value.x, main[ix].t1);
                var grade = exams
                    ?.getExam(examInd)
                    .getStudent(studentInd)
                    .getCourse(courseInd);

                dynamic result;
                switch (gType) {
                  case GradeTypes.numb:
                    result = grade?.numb;
                    break;
                  case GradeTypes.rank:
                    result = grade?.rank;
                    break;
                  default:
                }
                return result;
              });
            },
          );
        },
      );
    }

    return result;
  }
}
