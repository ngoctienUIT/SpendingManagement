import 'package:fluttertoast/fluttertoast.dart';

Future<bool> onWillPop(
    {required Function(DateTime?) action, DateTime? currentBackPressTime}) {
  DateTime now = DateTime.now();
  if (currentBackPressTime == null ||
      now.difference(currentBackPressTime) > const Duration(seconds: 3)) {
    action(now);
    Fluttertoast.showToast(msg: "Nhấn thêm lần nữa để thoát");
    return Future.value(false);
  }
  return Future.value(true);
}
