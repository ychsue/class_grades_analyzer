import 'dart:core';

/// [data] is the grade provided by the teacher, it might be a number or A++ and so on.
/// [numb] needs a function to translate from [data] if the [data] is not a number.
/// [rank] is based on each exam
class OneRecordModel {
  dynamic data; // might be A++, A+ and so on
  num? numb;
  int? rank;

  OneRecordModel({this.data});

  OneRecordModel.fromJson(Map<String, dynamic> json) {
    this.data = json['data'];
    this.numb = json['num'];
    this.rank = json['rank'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['data'] = this.data;
    data['num'] = this.numb;
    data['rank'] = this.rank;

    return data;
  }
}
