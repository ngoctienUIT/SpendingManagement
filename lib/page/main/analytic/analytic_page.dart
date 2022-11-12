import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:spending_management/constants/function/get_data_spending.dart';
import 'package:spending_management/constants/function/get_date.dart';
import 'package:spending_management/models/spending.dart';
import 'package:spending_management/page/main/analytic/chart/column_chart.dart';
import 'package:spending_management/page/main/analytic/chart/pie_chart.dart';
import 'package:spending_management/page/main/analytic/search_page.dart';
import 'package:spending_management/page/main/analytic/widget/custom_tabbar.dart';
import 'package:spending_management/page/main/analytic/widget/show_date.dart';
import 'package:spending_management/page/main/analytic/widget/show_list_spending.dart';
import 'package:spending_management/page/main/analytic/widget/tabbar_chart.dart';
import 'package:spending_management/page/main/analytic/widget/tabbar_type.dart';
import 'package:spending_management/page/main/analytic/widget/total_report.dart';
import 'package:spending_management/setting/localization/app_localizations.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AnalyticPage extends StatefulWidget {
  const AnalyticPage({Key? key}) : super(key: key);

  @override
  State<AnalyticPage> createState() => _AnalyticPageState();
}

class _AnalyticPageState extends State<AnalyticPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late TabController _chartController;
  late TabController _typeController;
  bool chart = false;
  DateTime now = DateTime.now();
  String date = "";

  @override
  void initState() {
    date = getWeek(now);
    _tabController = TabController(length: 3, vsync: this);
    _chartController = TabController(length: 2, vsync: this);
    _typeController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      now = DateTime.now();
      setState(() {
        if (_tabController.index == 0) {
          date = getWeek(now);
        } else if (_tabController.index == 1) {
          date = getMonth(now);
        } else {
          date = getYear(now);
        }
      });
    });
    _chartController.addListener(() {
      setState(() {
        if (_chartController.index == 0) {
          chart = false;
        } else {
          chart = true;
        }
      });
    });
    _typeController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _chartController.dispose();
    _typeController.dispose();
    super.dispose();
  }

  bool checkDate(DateTime date) {
    if (_tabController.index == 0) {
      int weekDay = now.weekday;
      DateTime firstDayOfWeek = DateTime(now.year, now.month, now.day)
          .subtract(Duration(days: weekDay - 1));

      DateTime lastDayOfWeek = firstDayOfWeek.add(const Duration(days: 6));

      if (firstDayOfWeek.isBefore(date) && lastDayOfWeek.isAfter(date) ||
          isSameDay(firstDayOfWeek, date) ||
          isSameDay(lastDayOfWeek, date)) return true;
    } else if (_tabController.index == 1 && isSameMonth(date, now)) {
      return true;
    } else if (_tabController.index == 2 && date.year == now.year) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            header(),
            const SizedBox(height: 20),
            Expanded(child: body()),
          ],
        ),
      ),
    );
  }

  Widget header() {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                AppLocalizations.of(context).translate('spending'),
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SearchPage(),
                    ),
                  );
                },
                icon: const Icon(
                  FontAwesomeIcons.magnifyingGlass,
                  size: 20,
                  color: Color.fromRGBO(180, 190, 190, 1),
                ),
              )
            ],
          ),
          const SizedBox(height: 20),
          CustomTabBar(controller: _tabController),
        ],
      ),
    );
  }

  Widget body() {
    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection("data")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Map<String, dynamic> data = {};
            if (snapshot.requireData.data() != null) {
              data = snapshot.requireData.data() as Map<String, dynamic>;
            }
            List<String> list = getDataSpending(
              data: data,
              index: _tabController.index,
              date: now,
            );

            return StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection("spending").snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var dataSpending = snapshot.data!.docs
                      .where((element) => list.contains(element.id))
                      .map((e) => Spending.fromFirebase(e))
                      .toList();

                  List<Spending> spendingList = dataSpending
                      .where((element) => checkDate(element.dateTime))
                      .toList();

                  List<Spending> classifySpending =
                      spendingList.where((element) {
                    if (_typeController.index == 0 && element.money > 0) {
                      return false;
                    }
                    if (_typeController.index == 1 && element.money < 0) {
                      return false;
                    }
                    return true;
                  }).toList();

                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                      child: Column(
                        children: [
                          showChart(classifySpending),
                          if (spendingList.isNotEmpty)
                            TotalReport(list: spendingList),
                          if (spendingList.isNotEmpty)
                            showListSpending(list: spendingList)
                        ],
                      ),
                    ),
                  );
                }
                return loading();
              },
            );
          }

          return loading();
        });
  }

  Widget showChart(List<Spending> classifySpending) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      color: const Color(0xff2c4260),
      child: Column(
        children: [
          const SizedBox(height: 10),
          showDate(
            date: date,
            index: _tabController.index,
            now: now,
            action: (date, now) {
              setState(() {
                this.date = date;
                this.now = now;
              });
            },
          ),
          TabBarType(controller: _typeController),
          classifySpending.isNotEmpty
              ? (chart
                  ? MyPieChart(list: classifySpending)
                  : ColumnChart(
                      index: _tabController.index,
                      list: classifySpending,
                      dateTime: now,
                    ))
              : SizedBox(
                  height: 350,
                  child: Center(
                    child: Text(
                      AppLocalizations.of(context).translate('no_data'),
                      style: const TextStyle(
                        color: Colors.blue,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
          tabBarChart(controller: _chartController),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget loading() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        color: const Color(0xff2c4260),
        child: Column(
          children: [
            const SizedBox(height: 10),
            showDate(
              date: date,
              index: 0,
              now: now,
              action: (date, now) {},
            ),
            TabBarType(controller: TabController(length: 2, vsync: this)),
            const SizedBox(
              height: 350,
              child: Center(child: CircularProgressIndicator()),
            ),
            tabBarChart(controller: TabController(length: 2, vsync: this)),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
