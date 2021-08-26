abstract class TabNames {
  static const home = "home";
  static const exam = "exam";
  static const student = "student";
  static const course = "course";

  static String name(TabsEnum tab) {
    String result = "";
    switch (tab) {
      case TabsEnum.home:
        result = home;
        break;
      case TabsEnum.exam:
        result = exam;
        break;
      case TabsEnum.student:
        result = student;
        break;
      case TabsEnum.course:
        result = course;
        break;
      default:
        assert(result == "", "tab->name fail");
    }
    return result;
  }

  static TabsEnum tab(String name) {
    var result;
    switch (name) {
      case home:
        result = TabsEnum.home;
        break;
      case exam:
        result = TabsEnum.exam;
        break;
      case student:
        result = TabsEnum.student;
        break;
      case course:
        result = TabsEnum.course;
        break;
      default:
        assert(result == null, "name->tab fail");
    }

    return result;
  }
}

enum TabsEnum {
  home,
  exam,
  student,
  course,
}
