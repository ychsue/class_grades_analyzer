import 'dart:async';

import 'package:class_grades_analyzer/controllers/my_global_controller.dart';
import 'package:class_grades_analyzer/data/model/dimensions/dim_ind_types.dart';
import 'package:class_grades_analyzer/data/model/dimensions/each_case_model.dart';
import 'package:class_grades_analyzer/data/model/dimensions/tab_names.dart';
import 'package:class_grades_analyzer/data/model/grade_or_rank.dart';
import 'package:class_grades_analyzer/data/model/pair.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart' as rxdart;

class DimsController extends GetxController {
  Rx<EachCaseModel> axes = (null as EachCaseModel).obs;
  late MyGlobalController gC;
  final _unsubscribed = StreamController<bool>.broadcast();

  @override
  void onInit() {
    gC = Get.find<MyGlobalController>();

    gC.cases.forEach((ele) {
      ele.stream.takeUntil(_unsubscribed.stream).listen((c) {
        setdata();
      });
    });
    gC.tab.stream.takeUntil(_unsubscribed.stream).listen((t) {
      setdata();
    });

    gC.gType.stream.takeUntil(_unsubscribed.stream).listen((t) {
      setdata();
    });
    super.onInit();
  }

  @override
  void onClose() {
    _unsubscribed.add(true);
    // axes.value = null;
    _unsubscribed.close();
    super.onClose();
  }

  RxList<List<List<dynamic>>> _data = <List<List<dynamic>>>[].obs;

  List<List<List<dynamic>>> get data => this._data;

  DimsIndTypes<List<PairModel<dynamic, bool>>>? get Inds {
    final buf = gC.cases.where((ele) => ele.value.main == gC.tab.value);
    final result = DimsIndTypes<List<PairModel<dynamic, bool>>>();
    if (buf.length == 0) return null;
    axes = buf.first;
    result
      ..main = axes.value.sortIndices
              .getDimByEnum(axes.value.main)
              ?.where((ele) => ele.t2)
              .toList() ??
          []
      ..x = axes.value.sortIndices
              .getDimByEnum(axes.value.x)
              ?.where((ele) => ele.t2)
              .toList() ??
          []
      ..y = axes.value.sortIndices
              .getDimByEnum(axes.value.y)
              ?.where((ele) => ele.t2)
              .toList() ??
          [];

    return result;
  }

  /// Its [data]'s structure is data[main][y][x]
  ///
  void setdata() {
    var exams = gC.exams.value;
    var gType = gC.gType.value;

    var indices = Inds;
    if (indices == null) return;
    var main = indices.main;
    var x = indices.x;
    var y = indices.y;

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
    if ((main.length != 0) && (x.length != 0) && (y.length != 0)) {
      result = List.generate(
        main.length,
        (imain) {
          feedIndices(axes.value.main, main[imain].t1);
          return List.generate(
            y.length,
            (iy) {
              feedIndices(axes.value.y, y[iy].t1);
              return List.generate(x.length, (ix) {
                feedIndices(axes.value.x, x[ix].t1);
                var grade = exams
                    ?.getExam(examInd)
                    .getStudent(studentInd)
                    .getCourse(courseInd);

                dynamic result;
                switch (gType) {
                  case GradeOrRankEnum.grade:
                    result = grade?.numb;
                    break;
                  case GradeOrRankEnum.rank:
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

    _data.value = result;
  }
}
