import 'package:spending_management/page/main/calendar/widget/custom_table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

String getWeek(DateTime dateTime) {
  int weekDay = dateTime.weekday;
  DateTime firstDayOfWeek = dateTime.subtract(Duration(days: weekDay - 1));
  return "${DateFormat("dd/MM/yyyy").format(firstDayOfWeek)} - ${DateFormat("dd/MM/yyyy").format(firstDayOfWeek.add(const Duration(days: 6)))}";
}

String getMonth(DateTime dateTime) {
  int lastDay = DateTime(dateTime.year, dateTime.month + 1, 0).day;
  return "01${DateFormat("/MM/yyyy").format(dateTime)} - $lastDay${DateFormat("/MM/yyyy").format(DateTime(dateTime.year, dateTime.month))}";
}

String getYear(DateTime dateTime) {
  return "01/01/${dateTime.year} - 31/12/${dateTime.year}";
}

List<DateTime> getListDayOfWeek(DateTime dateTime) {
  List<DateTime> list = [];
  int weekDay = dateTime.weekday;
  DateTime firstDayOfWeek = dateTime.subtract(Duration(days: weekDay - 1));
  DateTime lastDayOfWeek = firstDayOfWeek.add(const Duration(days: 6));
  while (firstDayOfWeek.difference(lastDayOfWeek).inDays <= 0) {
    list.add(firstDayOfWeek);
    firstDayOfWeek = firstDayOfWeek.add(const Duration(days: 1));
  }
  return list;
}

List<DateTime> getListWeekOfMonth(DateTime dateTime) {
  bool check = true;
  DateTime date = DateTime(dateTime.year, dateTime.month, 1);
  List<DateTime> list = [date];
  while (check) {
    int weekDay = date.weekday;
    DateTime lastWeek = date.add(Duration(days: 7 - weekDay));
    check = isSameMonth(date, lastWeek);
    if (!check) {
      lastWeek = DateTime(
          dateTime.year,
          dateTime.month,
          dateTime.month < 12
              ? DateTime(dateTime.year, dateTime.month + 1, 0).day
              : DateTime(dateTime.year + 1, 1, 0).day);
    }
    if (check) {
      date = lastWeek.add(const Duration(days: 1));
      list.add(date);
    }
  }
  return list;
}

List<DateTime> getListMonthOfYear(DateTime dateTime) {
  List<DateTime> list = [];
  for (int i = 1; i <= 12; i++) {
    list.add(DateTime(dateTime.year, i, 1));
  }
  return list;
}

bool checkOnWeek(DateTime dateTime, DateTime date) {
  DateTime lastWeek = dateTime.add(Duration(days: 7 - dateTime.weekday));
  if (!isSameMonth(dateTime, lastWeek)) {
    lastWeek = DateTime(
        dateTime.year,
        dateTime.month,
        dateTime.month < 12
            ? DateTime(dateTime.year, dateTime.month + 1, 0).day
            : DateTime(dateTime.year + 1, 1, 0).day);
  }
  return dateTime.isBefore(date) && lastWeek.isAfter(date) ||
      isSameDay(date, dateTime) ||
      isSameDay(date, lastWeek);
}
