import 'package:spending_management/constants/function/list_categories.dart';
import 'package:flutter/material.dart';
import 'package:spending_management/models/spending.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:spending_management/setting/localization/app_localizations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
  late Spending indexcate;

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
      backgroundColor: const Color.fromRGBO(250, 250, 250, 1),
      appBar: AppBar(
        title: const Text("Calendar", style: TextStyle(color: Colors.cyan),),
        centerTitle: true,
      ),
      body: Column(
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
              selectedDecoration: const BoxDecoration(
                color: Colors.cyanAccent,
                shape: BoxShape.circle,
                //borderRadius: BorderRadius.circular(6.0),
              ),
              cellPadding: const EdgeInsets.all(0),
              selectedTextStyle: const TextStyle(color: Colors.green),
              todayDecoration: const BoxDecoration(
                color: Colors.cyanAccent,
                shape: BoxShape.rectangle,
                //borderRadius: BorderRadius.circular(6.0),
              ),
              defaultDecoration: const BoxDecoration(
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
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.black54),
            ),
            rowHeight: 40,
            // locale: 'vi',
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  height: 48,
                  margin:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
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
                          Text(
                            AppLocalizations.of(context).translate('income'),
                            style:
                                const TextStyle(fontSize: 15, color: Colors.black54),
                          ),
                          const Text(
                            "0vnd",
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.lightBlue),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 48,
                  margin:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
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
                          Text(
                            AppLocalizations.of(context).translate('spending'),
                            style:
                                const TextStyle(fontSize: 15, color: Colors.black54),
                          ),
                          const Text(
                            "0vnd",
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.red),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 48,
                  margin:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
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
                          Text(
                            AppLocalizations.of(context).translate('total'),
                            style:
                                const TextStyle(fontSize: 15, color: Colors.black54),
                          ),
                          const Text(
                            "0vnd",
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.lightBlue),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: 48,
            margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 2),
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
                    Text(
                      AppLocalizations.of(context).translate('opening_balance'),
                      style: const TextStyle(fontSize: 15, color: Colors.black54),
                    ),
                    const Text(
                      "0vnd",
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.lightBlue),
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      AppLocalizations.of(context).translate('surplus'),
                      style: const TextStyle(fontSize: 15, color: Colors.black54),
                    ),
                    const Text(
                      "0vnd",
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.lightBlue),
                    )
                  ],
                ),
              ],
            ),
          ),
          Container(
            height: 210,
            margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
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
            child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('spending')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  final data = snapshot.requireData;

                  return ListView.builder(
                    itemCount: data.size,
                    itemBuilder: (context, index) {
                      //  var value_category = int.tryParse(" ${data.docs[index]['type']}");
                      indexcate=Spending.fromFirebase(data.docs[index]);

                      return Container(
                        //height: 48,
                        margin: const EdgeInsets.symmetric(
                            vertical: 3, horizontal: 3),
                        padding: const EdgeInsets.all(0),
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
                        child: Column(
                          children: [
                            Row(
                              textBaseline: TextBaseline.ideographic,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  margin:
                                      const EdgeInsets.only(top: 5, left: 10),
                                  padding: const EdgeInsets.all(0),
                                  child:  Text(
                                    "${indexcate.dateTime}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Column(
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.only(
                                                top: 5, left: 15, bottom: 10),
                                            padding: const EdgeInsets.all(0),
                                            child: ImageIcon(
                                              AssetImage(categories[indexcate.type]['icon']),
                                              color: Colors.black87,
                                              size: 30,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        width: 170,
                                        margin: const EdgeInsets.only(
                                            left: 10,top: 5),
                                        padding: const EdgeInsets.all(0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              AppLocalizations.of(context)
                                                  .translate(
                                                categories[indexcate.type]['name'],
                                              ),
                                              style: const TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black87),
                                            ),
                                            Text(
                                              " ${data.docs[index]['note']}",
                                              style: const TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                  fontSize: 15,
                                                  color: Colors.black38),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(

                                  padding: const EdgeInsets.only(
                                      top: 8, right: 8),
                                  width: 140,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        "  ${data.docs[index]['money']}Vnd",
                                        style:  TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600,
                                          color: data.docs[index]['money'] >= 0 ? Colors.blueAccent : Colors.red,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                      //Text( " my name ${data.docs[index]['note']}");
                    },
                  );
                }),
          ),
        ],
      ),
    );
  }
}
