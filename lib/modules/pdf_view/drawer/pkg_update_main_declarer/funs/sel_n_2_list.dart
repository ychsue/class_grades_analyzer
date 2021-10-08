/// Get a list of number from [selN],
///
/// if it cannot parse the string [selN], it will throw an exception for you.
List<int> selN2List(String selN) {
  final List<int> result = [];
  //1. check whether all chars are legal
  final pat = RegExp(r"^[0-9,~]*$");
  if (pat.hasMatch(selN) == false)
    throw Exception("請輸入如 2~4,1，這樣會得到2,3,4,1"); //I18N

  //2. slice the selN by ","
  final segs = selN.split(",");
  for (var seg in segs) {
    //2.1 check whether it has "~"
    final startTo = seg.split("~");
    bool hasError = false;
    if (startTo.length == 1) {
      //2.1.1 No "~", check whether it is a number
      final val = int.tryParse(seg);
      if (val == null) {
        hasError = true;
      } else {
        result.add(val);
      }
    } else if (startTo.length == 2) {
      //2.1.2 If it only has one "~"
      final start = int.tryParse(startTo[0]);
      final end = int.tryParse(startTo[1]);
      if (start == null || end == null) {
        hasError = true;
      } else {
        for (var i = start; true; i += ((end > start) ? 1 : -1)) {
          result.add(i);
          if (i == end) break;
        }
      }
    } else {
      hasError = true;
    }

    if (hasError) throw Exception("有誤的要求：'$seg'"); //I18N
  }

  return result;
}
