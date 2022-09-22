import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:spending_management/constants/app_styles.dart';
import 'package:spending_management/page/main/analytic/chart/column_chart.dart';
import 'package:spending_management/page/main/analytic/chart/pie_chart.dart';

class AnalyticPage extends StatefulWidget {
  const AnalyticPage({Key? key}) : super(key: key);

  @override
  State<AnalyticPage> createState() => _AnalyticPageState();
}

class _AnalyticPageState extends State<AnalyticPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  bool chart = true;
  DateTime now = DateTime.now();
  String date = "";

  @override
  void initState() {
    date = getWeek(now);
    _tabController = TabController(length: 3, vsync: this);
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

    super.initState();
  }

  String getWeek(DateTime dateTime) {
    int weekDay = dateTime.weekday;
    DateTime firstDayOfWeek = dateTime.subtract(Duration(days: weekDay - 1));
    return "${DateFormat("dd/MM/yyyy").format(firstDayOfWeek)} - ${DateFormat("dd/MM/yyyy").format(firstDayOfWeek.add(const Duration(days: 6)))}";
  }

  String getMonth(DateTime dateTime) {
    int lastDay = DateTime(now.year, now.month + 1, 0).day;
    return "01${DateFormat("/MM/yyyy").format(dateTime)} - $lastDay${DateFormat("/MM/yyyy").format(DateTime(dateTime.year, dateTime.month))}";
  }

  String getYear(DateTime dateTime) {
    return "01/01/${dateTime.year} - 31/12/${dateTime.year}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                children: const [
                  Text(
                    "Spending",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                height: 40,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(242, 243, 247, 1),
                    borderRadius: BorderRadius.circular(10)),
                child: TabBar(
                    controller: _tabController,
                    labelColor: Colors.black87,
                    labelStyle: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                    unselectedLabelColor: const Color.fromRGBO(45, 216, 198, 1),
                    unselectedLabelStyle: AppStyles.p,
                    isScrollable: false,
                    indicatorColor: Colors.red,
                    indicator: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    tabs: const [
                      Tab(text: "Weekly"),
                      Tab(text: "Monthly"),
                      Tab(text: "Yearly")
                    ]),
              ),
              const SizedBox(height: 20),
              Card(
                // elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4)),
                color: const Color(0xff2c4260),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              setState(() {
                                if (_tabController.index == 0) {
                                  now = now.subtract(const Duration(days: 6));
                                  date = getWeek(now);
                                } else if (_tabController.index == 1) {
                                  now = DateTime(now.year, now.month - 1);
                                  date = getMonth(now);
                                } else {
                                  now = DateTime(now.year - 1);
                                  date = getYear(now);
                                }
                              });
                            },
                            child: const Icon(Icons.arrow_back_ios_new_rounded),
                          ),
                          Text(
                            date,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                if (_tabController.index == 0) {
                                  now = now.add(const Duration(days: 6));
                                  date = getWeek(now);
                                } else if (_tabController.index == 1) {
                                  now = DateTime(now.year, now.month + 1);
                                  date = getMonth(now);
                                } else {
                                  now = DateTime(now.year + 1);
                                  date = getYear(now);
                                }
                              });
                            },
                            child: const Icon(Icons.arrow_forward_ios_rounded),
                          )
                        ],
                      ),
                    ),
                    chart ? const MyPieChart() : const MyPieChart(),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    chart = !chart;
                  });
                },
                child: const Text("change"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
