import 'dart:convert';

class PairModel<T1, T2> {
  late T1 t1;
  late T2 t2;

  PairModel(T1 t1, T2 t2)
      : t1 = t1,
        t2 = t2;

  PairModel.of(PairModel<T1, T2> pair) {
    this.t1 = pair.t1;
    this.t2 = pair.t2;
  }

  PairModel.fromJson(Map<String, dynamic> json) {
    this.t1 = jsonDecode(json['t1']);
    this.t2 = jsonDecode(json['t2']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['t1'] = jsonEncode(this.t1);
    data['t2'] = jsonEncode(this.t2);
    return data;
  }
}
