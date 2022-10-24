import 'package:intl/intl.dart';

bool isSameMonth(DateTime day1, DateTime day2) =>
    day1.year == day2.year && day1.month == day2.month;

List<String> getDataSpending(
    {required Map<String, dynamic> data,
    required int index,
    required DateTime date}) {
  List<String> list = [];
  if (index == 0) {
    int weekDay = date.weekday;
    DateTime firstDayOfWeek = date.subtract(Duration(days: weekDay - 1));
    DateTime lastDayOfWeek = firstDayOfWeek.add(const Duration(days: 6));
    if (data[DateFormat("MM_yyyy").format(firstDayOfWeek)] != null) {
      list =
          (data[DateFormat("MM_yyyy").format(firstDayOfWeek)] as List<dynamic>)
              .map((e) => e.toString())
              .toList();
    }
    if (!isSameMonth(firstDayOfWeek, lastDayOfWeek) &&
        data[DateFormat("MM_yyyy").format(lastDayOfWeek)] != null) {
      list.addAll(
          (data[DateFormat("MM_yyyy").format(lastDayOfWeek)] as List<dynamic>)
              .map((e) => e.toString())
              .toList());
    }
  } else if (index == 1 && data[DateFormat("MM_yyyy").format(date)] != null) {
    list = (data[DateFormat("MM_yyyy").format(date)] as List<dynamic>)
        .map((e) => e.toString())
        .toList();
  } else if (index == 2) {
    for (int i = 1; i < 13; i++) {
      String dateString = DateFormat("MM_yyyy").format(DateTime(date.year, i));
      if (data[dateString] != null) {
        list.addAll((data[dateString] as List<dynamic>)
            .map((e) => e.toString())
            .toList());
      }
    }
  }
  return list;
}
