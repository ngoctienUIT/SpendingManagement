import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  // Map<DateTime,List<Event>> selectedEvents;
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

  @override
  void initState() {
    // selectedEvents = {   };
    super.initState();
  }
  // List<Event> _getEventsfromDay(DateTime date){
  //   // return selectedEvents[date] ?? [];
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calendar"),
        centerTitle: true,
      ),
      body: TableCalendar(
        focusedDay: focusedDay,
        firstDay: DateTime(1990),
        lastDay: DateTime(2050),
        calendarFormat: format,

        onFormatChanged: (CalendarFormat format) {
          setState(() {
            format = format;
          });
        },
        startingDayOfWeek: StartingDayOfWeek.monday,
        daysOfWeekVisible: true,

        //Chọn ngày
        onDaySelected: (DateTime selectDay, DateTime focusDay) {
          setState(() {
            selectedDay = selectDay;
            focusedDay = focusDay;
          });
        },
        selectedDayPredicate: (DateTime date) {
          return isSameDay(selectedDay, date);
        },

        eventLoader: (day) {
          return ["1"];
        },
        // calendarBuilders: CalendarBuilders(
        //   markerBuilder: (context, day, events) {
        //     return Text(events.length.toString());
        //   },
        // ),
        daysOfWeekStyle: const DaysOfWeekStyle(
          decoration: BoxDecoration(color: Colors.black12),
          weekendStyle: TextStyle(color: Colors.redAccent),
          weekdayStyle: TextStyle(color: Colors.black54),
        ),
        //Style
        calendarStyle: CalendarStyle(
          tableBorder: const TableBorder(
            bottom: BorderSide(
                color: Colors.black12,
                width: 1.0,
                style: BorderStyle.solid,
                strokeAlign: StrokeAlign.inside),
            horizontalInside: BorderSide(
                color: Colors.black12,
                width: 1.0,
                style: BorderStyle.solid,
                strokeAlign: StrokeAlign.inside),
            verticalInside: BorderSide(
                color: Colors.black12,
                width: 1.0,
                style: BorderStyle.solid,
                strokeAlign: StrokeAlign.inside),
            left: BorderSide(
                color: Colors.black12,
                width: 1.0,
                style: BorderStyle.solid,
                strokeAlign: StrokeAlign.inside),
            right: BorderSide(
                color: Colors.black12,
                width: 1.0,
                style: BorderStyle.solid,
                strokeAlign: StrokeAlign.inside),
            top: BorderSide(
                color: Colors.black12,
                width: 1.0,
                style: BorderStyle.solid,
                strokeAlign: StrokeAlign.inside),
          ),
          isTodayHighlighted: true,
          selectedDecoration: BoxDecoration(
            color: Colors.cyanAccent,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(6.0),
          ),
          cellPadding: const EdgeInsets.all(0),
          selectedTextStyle: const TextStyle(color: Colors.green),
          todayDecoration: BoxDecoration(
            color: Colors.cyanAccent,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(6.0),
          ),
          defaultDecoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(6.0),
          ),
          weekendDecoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(6.0)),
          outsideDaysVisible: true,
          todayTextStyle: const TextStyle(color: Colors.green),
        ),
        headerStyle: HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
          rightChevronPadding:
              const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
          decoration: BoxDecoration(
            color: Colors.greenAccent,
            borderRadius: BorderRadius.circular(10.0),
          ),
          headerPadding:
              const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
          headerMargin:
              const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
          titleTextStyle: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black54),
        ),
        rowHeight: 40,
        // locale: 'vi',
      ),
    );
  }
}
