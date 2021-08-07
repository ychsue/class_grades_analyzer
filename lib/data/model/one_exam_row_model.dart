/// 一次大考的成績中每個人的各科成績
/// [id] : 由於考量到可能有學生轉進或轉出，只靠 "座號" 好像不夠，
///         所以，規定其為 {A:0, B:NAME ...}`
/// [data] : 以 Map<String, dynamic> 來存各科成績
class OneExamRowModel {
  Map<String, dynamic> id = {};
  Map<String, dynamic> data = {};

  OneExamRowModel({required this.id, required this.data});

  OneExamRowModel.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['data'] = this.data;
    data['id'] = this.id;
    return data;
  }
}
