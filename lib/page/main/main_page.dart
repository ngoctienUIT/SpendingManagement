import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spending_management/constants/app_colors.dart';
import 'package:spending_management/constants/function/on_will_pop.dart';
import 'package:spending_management/page/main/analytic/analytic_page.dart';
import 'package:spending_management/page/main/calendar/calendar_page.dart';
import 'package:spending_management/page/main/home/home_page.dart';
import 'package:spending_management/page/main/setting/setting_page.dart';
import 'package:spending_management/page/main/widget/input_income.dart';
import 'package:spending_management/page/main/widget/input_spending.dart';
import 'package:spending_management/page/main/widget/item_bottom_tab.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentTab = 0;
  List<Widget> screens = [
    const HomePage(),
    const CalendarPage(),
    const AnalyticPage(),
    const SettingPage()
  ];

  DateTime? currentBackPressTime;
  final PageStorageBucket bucket = PageStorageBucket();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () => onWillPop(
          action: (now) => currentBackPressTime = now,
          currentBackPressTime: currentBackPressTime,
        ),
        child: PageStorage(
          bucket: bucket,
          child: screens[currentTab],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showBottomSheet(),
        child: const Icon(Icons.add_rounded),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: AppColors.whisperBackground,
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  itemBottomTab(
                    text: "Home",
                    index: 0,
                    current: currentTab,
                    icon: FontAwesomeIcons.house,
                    action: () {
                      setState(() {
                        currentTab = 0;
                      });
                    },
                  ),
                  itemBottomTab(
                    text: "Calendar",
                    index: 1,
                    current: currentTab,
                    size: 28,
                    icon: Icons.calendar_month_outlined,
                    action: () {
                      setState(() {
                        currentTab = 1;
                      });
                    },
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  itemBottomTab(
                    text: "Analytic",
                    index: 2,
                    current: currentTab,
                    icon: FontAwesomeIcons.chartPie,
                    action: () {
                      setState(() {
                        currentTab = 2;
                      });
                    },
                  ),
                  itemBottomTab(
                    text: "Setting",
                    index: 3,
                    current: currentTab,
                    icon: FontAwesomeIcons.gear,
                    action: () {
                      setState(() {
                        currentTab = 3;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(150, 10.0, 150, 0.0),
            height: 8.0,
            width: 80.0,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.add_a_photo_outlined,
                  size: 30,
                ),
                onPressed: () {},
              ),
              TextButton(
                child: Container(
                  padding: const EdgeInsets.only(right: 8),
                  child: const Text(
                    'Bỏ qua',
                    style: TextStyle(fontSize: 18, color: Colors.redAccent),
                  ),
                ),
                onPressed: () {},
              ),
            ],
          ),
          const Text(
            "Nhập thu chi",
            style: TextStyle(
              color: Colors.orange,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          DefaultTabController(
            length: 2,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(0),
                  margin: const EdgeInsets.all(10),
                  width: 250,
                  decoration: const BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  child: TabBar(
                    padding: const EdgeInsets.all(3),
                    tabs: [
                      Container(
                        padding: const EdgeInsets.all(0),
                        width: 100,
                        // color: Colors.black,
                        height: 30,
                        child: const Center(
                          child: Text(
                            "Tiền chi ",
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(0),
                        width: 100,
                        height: 30,
                        child: const Center(
                          child: Text(
                            "Tiền thu",
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ),
                    ],
                    unselectedLabelColor: Colors.black54,
                    labelColor: Colors.black,
                    unselectedLabelStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    labelStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    indicatorSize: TabBarIndicatorSize.label,
                    indicator: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 2),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  height: 500,
                  child: const TabBarView(
                    children: [
                      InputSpending(),
                      InputIncome(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
