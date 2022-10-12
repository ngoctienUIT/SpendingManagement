import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spending_management/constants/app_colors.dart';
import 'package:spending_management/constants/function/on_will_pop.dart';
import 'package:spending_management/page/main/analytic/analytic_page.dart';
import 'package:spending_management/page/main/calendar/calendar_page.dart';
import 'package:spending_management/page/main/home/home_page.dart';
import 'package:spending_management/page/main/setting/setting_page.dart';
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
        onPressed: () {
          showModalBottomSheet(
              context: context,

              isScrollControlled: false,
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              
              builder: (context)=>
                  Column(

                    children: [
                      Text("Nhập thu chi",style:
                      TextStyle(color: Colors.orange,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                      ),
                      DefaultTabController(
                        length: 2,
                        initialIndex: 0,
                        child:
                         Container(
                              // decoration: BoxDecoration(
                              //   color: Colors.black,
                              //   borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                              // ),
                              margin: EdgeInsets.symmetric(vertical: 0) ,
                              padding: EdgeInsets.all(10),
                              child: Container(
                                width: 260,
                                decoration: BoxDecoration(

                                  color: Colors.grey,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(30),
                                  ),
                                ),
                                child: TabBar(

                                  padding: EdgeInsets.all(5),
                                  tabs: <Widget>[

                                    Container(
                                      padding: const EdgeInsets.all(10.0),
                                      width: 100,
                                      height: 40,
                                      child: Center(
                                        child:Text("Tiền chi "),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(10.0),
                                      width: 100,
                                      height: 40,
                                      child: Center(child:
                                      Text("Tiền thu"),
                                      ),
                                    ),
                                  ],
                                  unselectedLabelColor: Colors.black54,
                                  labelColor: Colors.black,
                                  unselectedLabelStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  labelStyle: TextStyle(
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
                            ),
                          ),
                    ],
                  ),
          );
        } ,

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
}
