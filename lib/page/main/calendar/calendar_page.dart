import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spending_management/constants/function/find_index.dart';
import 'package:spending_management/controls/spending_firebase.dart';
import 'package:spending_management/models/spending.dart';
import 'package:spending_management/page/main/calendar/widget/build_spending.dart';
import 'package:spending_management/page/main/calendar/widget/custom_table_calendar.dart';
import 'package:spending_management/page/main/calendar/widget/total_spending.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  bool check = true;
  List<Spending>? _currentSpendingList;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  var numberFormat = NumberFormat.currency(locale: "vi_VI");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection("data")
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var data = {};

                if (snapshot.requireData.data() != null) {
                  data = snapshot.requireData.data() as Map<String, dynamic>;
                }
                List<String> list = [];
                check = true;

                return StatefulBuilder(builder: (context, setState) {
                  if (data[DateFormat("MM_yyyy").format(_focusedDay)] != null) {
                    list = (data[DateFormat("MM_yyyy").format(_focusedDay)]
                    as List<dynamic>)
                        .map((e) => e.toString())
                        .toList();
                  }

                  return FutureBuilder(
                      future: SpendingFirebase.getSpendingList(list),
                      builder: (context, futureSnapshot) {
                        if (futureSnapshot.hasData) {
                          var dataSpending = futureSnapshot.requireData;

                          List<Spending> spendingList = dataSpending
                              .where((element) =>
                              isSameDay(element.dateTime, _selectedDay))
                              .toList();

                          if (check) {
                            _currentSpendingList = spendingList;
                            check = false;
                          }

                          return Column(
                            children: [
                              CustomTableCalendar(
                                  focusedDay: _focusedDay,
                                  selectedDay: _selectedDay,
                                  dataSpending: dataSpending,
                                  onPageChanged: (focusedDay) =>
                                      setState(() => _focusedDay = focusedDay),
                                  onDaySelected: (selectedDay, focusedDay) {
                                    setState(() {
                                      _focusedDay = focusedDay;
                                      _selectedDay = selectedDay;
                                      check = true;
                                    });
                                  }),
                              const SizedBox(height: 5),
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      if (_currentSpendingList!.isNotEmpty)
                                        TotalSpending(
                                            list: _currentSpendingList),
                                      BuildSpending(
                                        spendingList: _currentSpendingList,
                                        date: _selectedDay,
                                        change: (spending) async {
                                          try {
                                            spending.image = await FirebaseStorage
                                                .instance
                                                .ref()
                                                .child(
                                                "spending/${spending.id}.png")
                                                .getDownloadURL();
                                          } catch (_) {}

                                          setState(() {
                                            if (isSameDay(spending.dateTime,
                                                _selectedDay)) {
                                              _currentSpendingList![findIndex(
                                                  _currentSpendingList!,
                                                  spending.id!)] = spending;
                                            } else {
                                              _currentSpendingList!.removeWhere(
                                                      (element) =>
                                                  element.id!.compareTo(
                                                      spending.id!) ==
                                                      0);
                                            }
                                          });
                                        },
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        }
                        return loadingData();
                      });
                });
              }
              return loadingData();
            }),
      ),
    );
  }

  Widget loadingData() {
    return Column(
      children: [
        CustomTableCalendar(
          focusedDay: _focusedDay,
          selectedDay: _selectedDay,
        ),
        const TotalSpending(),
        const Expanded(child: BuildSpending())
      ],
    );
  }
}