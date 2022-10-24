import 'package:intl/intl.dart';

String getWeek(DateTime dateTime) {
  int weekDay = dateTime.weekday;
  DateTime firstDayOfWeek = dateTime.subtract(Duration(days: weekDay - 1));
  return "${DateFormat("dd/MM/yyyy").format(firstDayOfWeek)} - ${DateFormat("dd/MM/yyyy").format(firstDayOfWeek.add(const Duration(days: 6)))}";
}

String getMonth(DateTime dateTime) {
  DateTime now = DateTime.now();
  int lastDay = DateTime(now.year, now.month + 1, 0).day;
  return "01${DateFormat("/MM/yyyy").format(dateTime)} - $lastDay${DateFormat("/MM/yyyy").format(DateTime(dateTime.year, dateTime.month))}";
}

String getYear(DateTime dateTime) {
  return "01/01/${dateTime.year} - 31/12/${dateTime.year}";
}
