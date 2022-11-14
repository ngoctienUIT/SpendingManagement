import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:spending_management/setting/localization/app_localizations.dart';

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
      //backgroundColor: Colors.white,
      backgroundColor: Color.fromRGBO(250, 250, 250, 1),
      appBar: AppBar(
        title: const Text("Calendar"),
        centerTitle: true,
      ),
      body:

      Column(

        children: [
          TableCalendar(
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
              isTodayHighlighted: false,
              selectedDecoration: BoxDecoration(
                color: Colors.cyanAccent,
                shape: BoxShape.circle,
                //borderRadius: BorderRadius.circular(6.0),
              ),
              cellPadding: const EdgeInsets.all(0),
              selectedTextStyle: const TextStyle(color: Colors.green),
              todayDecoration: BoxDecoration(
                color: Colors.cyanAccent,
                shape: BoxShape.rectangle,
                //borderRadius: BorderRadius.circular(6.0),
              ),
              defaultDecoration: BoxDecoration(
                shape: BoxShape.rectangle,
                //borderRadius: BorderRadius.circular(6.0),
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
                color: Colors.black12,
                borderRadius: BorderRadius.circular(15.0),
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
          Row(
            
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Container(
                height: 50,
                margin: const EdgeInsets.symmetric(vertical:  ,horizontal: 2  ),
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 1,
                        blurRadius: 10,
                      ),
                    ]
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text( AppLocalizations.of(context).translate('income'),style: TextStyle( fontSize: 15,color: Colors.black54),),
                        Text("0vnd",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: Colors.lightBlue),)
                      ],
                    ),
                  ],
                ),
              ),),

              Expanded(child: Container(
                height: 50,
                margin: const EdgeInsets.symmetric(vertical: 5 ,horizontal: 2  ),
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 1,
                        blurRadius: 10,
                      ),
                    ]),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text( AppLocalizations.of(context).translate('spending'),style: TextStyle( fontSize: 15,color: Colors.black54),),
                        Text("0vnd",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: Colors.red),)
                      ],
                    ),
                  ],
                ),
              ),),

              Expanded(child: Container(
                height: 50,
                margin: const EdgeInsets.symmetric(vertical: 5 ,horizontal: 2  ),
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 1,
                        blurRadius: 10,
                      ),
                    ]),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text( AppLocalizations.of(context).translate('total'),style: TextStyle( fontSize: 15,color: Colors.black54),),
                        Text("0vnd",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: Colors.lightBlue),)
                      ],
                    ),
                  ],
                ),
              ),),



            ],
          ),
          Container(
            height: 55,
            margin: const EdgeInsets.symmetric(vertical: 0 , horizontal: 5  ),
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 10,
                  ),
                ]),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text( AppLocalizations.of(context).translate('opening_balance'),style: TextStyle( fontSize: 15,color: Colors.black54),),
                    Text("0vnd",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: Colors.lightBlue),)

                  ],
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text( AppLocalizations.of(context).translate('surplus'),style: TextStyle( fontSize: 15,color: Colors.black54),),
                    Text("0vnd",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: Colors.lightBlue),)

                  ],
                ),

              ],
            ),
          ),

          Container(
            height: 195,
            margin: const EdgeInsets.symmetric(vertical: 5 , horizontal: 5  ),
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 10,
                  ),
                ]),

          ),
        ],
      ),
    );
  }
}
