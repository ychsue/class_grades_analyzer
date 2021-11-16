String num2String(dynamic input, [int decimalDigit = 2]) {
  var result = input.toString();

  if (input is num) {
    // || input is int || input is double) {
    var indOfDot = result.indexOf('.');
    if (indOfDot >= 0 && (indOfDot + decimalDigit) < result.length)
      result = result.substring(0, indOfDot + decimalDigit + 1);
  }
  return result;
}
