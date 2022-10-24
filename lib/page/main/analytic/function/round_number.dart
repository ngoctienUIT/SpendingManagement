import 'dart:math';

double roundNumber({required double number}) {
  // double div = 10;
  // while (number / div >= 10) {
  //   div *= 10;
  // }
  // int y =
  //     int.tryParse((number / div).toString().split('.')[0].substring(0, 1))!;
  // return (y + 1) * div;
  String num = number.toString();
  if (num[1].isEmpty && int.parse(num[1]) < 5) {
    return double.parse("${num[0]}5") * pow(10, num.length - 4);
  } else {
    return (double.parse(num[0]) + 1) * pow(10, num.length - 3);
  }
}
