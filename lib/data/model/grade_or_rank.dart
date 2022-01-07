enum GradeOrRankEnum {
  grade,
  rank,
}

extension GradeOrRankEnumExtension on GradeOrRankEnum {
  static GradeOrRankEnum fromString(String input) {
    return GradeOrRankEnum.values.firstWhere(
      (element) => element.toString().contains(input),
      orElse: () => GradeOrRankEnum.grade,
    );
  }
}

class GradeOrRankModel {
  String gradeName = 'grade';
  String rankName = 'rank';

  GradeOrRankModel({this.gradeName = 'grade', this.rankName = 'rank'});

  GradeOrRankEnum? name2Enum(String name) {
    if (name == gradeName) return GradeOrRankEnum.grade;
    if (name == rankName) return GradeOrRankEnum.rank;
    return null;
  }

  String? enum2Name(GradeOrRankEnum type) {
    switch (type) {
      case GradeOrRankEnum.grade:
        return gradeName;
      case GradeOrRankEnum.rank:
        return rankName;
      default:
        return null;
    }
  }

  GradeOrRankModel.fromJson(Map<String, dynamic> json) {
    this.gradeName = json['gradeName'];
    this.rankName = json['rankName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['gradeName'] = this.gradeName;
    data['rankName'] = this.rankName;
    return data;
  }
}
