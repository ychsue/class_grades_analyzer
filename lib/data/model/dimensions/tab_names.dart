abstract class TabNames {
  static const home = "home";
  static const exam = "exam";
  static const student = "student";
  static const course = "course";

  String name(Tabs tab) {
    String result = "";
    switch (tab) {
      case Tabs.home:
        result = home;
        break;
      case Tabs.exam:
        result = exam;
        break;
      case Tabs.student:
        result = student;
        break;
      case Tabs.course:
        result = course;
        break;
      default:
        assert(result == "", "tab->name fail");
    }
    return result;
  }

  Tabs tab(String name) {
    var result;
    switch (name) {
      case home:
        result = Tabs.home;
        break;
      case exam:
        result = Tabs.exam;
        break;
      case student:
        result = Tabs.student;
        break;
      case course:
        result = Tabs.course;
        break;
      default:
        assert(result == null, "name->tab fail");
    }

    return result;
  }
}

enum Tabs {
  home,
  exam,
  student,
  course,
}
