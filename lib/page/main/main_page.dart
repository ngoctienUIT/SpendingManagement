import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spending_management/constants/app_colors.dart';
import 'package:spending_management/constants/function/List_Categories.dart';
import 'package:spending_management/constants/function/on_will_pop.dart';
import 'package:spending_management/page/main/analytic/analytic_page.dart';
import 'package:spending_management/page/main/calendar/calendar_page.dart';
import 'package:spending_management/page/main/home/home_page.dart';
import 'package:spending_management/page/main/setting/setting_page.dart';
import 'package:spending_management/page/main/widget/item_bottom_tab.dart';
//import 'package:group_button/group_button.dart';

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
  DateTime dateTime=DateTime.now();
  int activeCategory=0;
  Color primary= Color(0xFFFF3378);
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
              isScrollControlled: true,
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              
              builder: (context)=>
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:<Widget> [
                        Padding(
                          padding: EdgeInsets.fromLTRB(150,10.0,150,0.0),
                          child: Container(
                            height: 8.0,
                            width: 80.0,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius:
                              BorderRadius.all(Radius.circular(8.0)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      IconButton(
                        icon: const Icon(Icons.add_a_photo_outlined,size: 30,),
                        onPressed: (){},
                      ),
                      TextButton(
                        child:
                          Container(
                            padding: EdgeInsets.only(right: 8),
                            child:
                              Text('Bỏ qua',style: TextStyle(fontSize: 18,color: Colors.redAccent),),
                          ),

                        onPressed: (){},
                      ),
                    ],),
                    Text("Nhập thu chi", style:
                    TextStyle(color: Colors.orange,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    ),
                    DefaultTabController(
                      length: 2,
                      child:
                      Column(
                        children: [
                          Container(
                          child:
                              Column(
                              mainAxisSize: MainAxisSize.min,
                               children: <Widget>[
                                 Container(
                                   padding: EdgeInsets.all(0),
                                   margin: EdgeInsets.all(10),
                                   width: 250,
                                   decoration: BoxDecoration(
                                     color: Colors.black12,
                                     borderRadius: BorderRadius.all(
                                       Radius.circular(30),
                                     ),
                                   ),
                                   child: TabBar(

                                     padding: EdgeInsets.all(3),
                                     tabs: <Widget>[

                                       Container(
                                         padding: const EdgeInsets.all(0),
                                         width: 100,
                                         // color: Colors.black,
                                         height: 30,
                                         child: Center(
                                           child: Text("Tiền chi ",style: TextStyle(fontSize: 15),),
                                         ),
                                       ),
                                       Container(
                                         padding: const EdgeInsets.all(0),
                                         width: 100,
                                         height: 30,
                                         child: Center(child:
                                         Text("Tiền thu",style: TextStyle(fontSize: 15),),
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

                                 Container(
                                   height: 500,
                                   child: TabBarView(
                                     children: <Widget> [
                                       Column(
                                         //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                         children: [
                                           Row(
                                             crossAxisAlignment: CrossAxisAlignment.center,
                                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                             children: <Widget> [
                                               SizedBox(
                                                 height:30,
                                                 width: 30,
                                               ),
                                               SizedBox(

                                                 child:Text(
                                                   "Ngày",
                                                   style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                                                 ),
                                                 height: 30,
                                                 width: 70,
                                               ),
                                               Expanded(
                                                 child: CupertinoButton(

                                                   color: Colors.black12,
                                                   borderRadius: BorderRadius.all(Radius.circular(10)),
                                                   child: Text("${dateTime.day}/${dateTime.month}/${dateTime.year}(${dateTime.weekday})",
                                                     style: TextStyle(
                                                       fontSize: 15,
                                                       color: Colors.black,
                                                     ),),
                                                   onPressed: () {
                                                     showCupertinoModalPopup(
                                                       context: context,
                                                       builder: (BuildContext context) => SizedBox(
                                                         height: 280,
                                                         child: CupertinoDatePicker(
                                                           backgroundColor: Colors.white,
                                                           initialDateTime: dateTime,
                                                           onDateTimeChanged: (DateTime newTime) {
                                                             setState(() =>dateTime = newTime);
                                                           },
                                                           use24hFormat: true,
                                                           mode: CupertinoDatePickerMode.date,
                                                         ),
                                                         // Column(
                                                         //   children: [
                                                             // Row(
                                                             //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                             //   children: [
                                                             //   TextButton(
                                                             //     child:
                                                             //     Container(
                                                             //       padding: EdgeInsets.only(right: 8),
                                                             //       child:
                                                             //       Text('Hủy',style: TextStyle(fontSize: 18,color: Colors.redAccent),),
                                                             //     ),
                                                             //     onPressed: (){},
                                                             //   ),
                                                             //   TextButton(
                                                             //     child:
                                                             //     Container(
                                                             //       padding: EdgeInsets.only(right: 8),
                                                             //       child:
                                                             //       Text('Chọn',style: TextStyle(fontSize: 18,color: Colors.redAccent),),
                                                             //     ),
                                                             //     onPressed: (){},
                                                             //   ),
                                                             //   ],
                                                             // ),
                                                             //   Row(
                                                             //     children: [
                                                             //       Expanded(child:
                                                             //       CupertinoDatePicker(
                                                             //         backgroundColor: Colors.white,
                                                             //         initialDateTime: dateTime,
                                                             //         onDateTimeChanged: (DateTime newTime) {
                                                             //           setState(() =>dateTime = newTime);
                                                             //         },
                                                             //         use24hFormat: true,
                                                             //         mode: CupertinoDatePickerMode.date,
                                                             //       ),),
                                                             // ],
                                                             // ),
                                                         //   ],
                                                         // ),
                                                       ),
                                                     );
                                                   },
                                                 ),
                                                 ),
                                               SizedBox(
                                                 height:30,
                                                 width: 30,
                                               ),
                                             ],
                                           ),
                                           Row(
                                             crossAxisAlignment: CrossAxisAlignment.center,

                                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: <Widget> [
                                                SizedBox(
                                                  height:30,
                                                  width: 30,
                                                ),
                                                SizedBox(child:
                                                Text(
                                                  "Ghi chú",
                                                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                                                ),
                                                  width: 70,
                                                  height: 30,
                                                ),
                                                  Expanded(
                                                    child: TextField(
                                                      decoration:
                                                      InputDecoration(hintText: 'Nhập ghi chú'),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height:30,
                                                  width: 30,
                                                ),
                                              ],
                                           ),
                                           Row(textBaseline: TextBaseline.alphabetic,
                                             crossAxisAlignment: CrossAxisAlignment.center,
                                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                             children: <Widget> [
                                               SizedBox(
                                                 height:30,
                                                 width: 30,
                                               ),
                                               SizedBox(
                                                 child: Text(
                                                   "Tiền chi",
                                                   style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                                                 ),
                                                 width: 70,
                                                 height: 30,
                                               ),
                                                 Expanded(

                                                   child: TextField(
                                                     keyboardType: TextInputType.number,
                                                     decoration:
                                                     InputDecoration(hintText: '0',hintStyle: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 20),),
                                                   ),
                                                 ),
                                               SizedBox(
                                                 height:30,
                                                 width: 30,
                                               ),
                                                   ],
                                           ),
                                           Row(
                                             mainAxisAlignment: MainAxisAlignment.start,
                                             children: [
                                               SizedBox(
                                                 height:30,
                                                 width: 30,
                                               ),
                                               Text(
                                                 "Danh mục",
                                                 style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                                               ),
                                             ],
                                           ),
                                          Container(
                                            padding: EdgeInsets.only(top: 5),
                                            child:SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child:Row(
                                                children:List.generate(categories.length, (index) {
                                                  return GestureDetector(
                                                    onTap: (){
                                                      setState(() {
                                                        activeCategory=index;
                                                      });
                                                    },
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(
                                                        left:10,
                                                      ),
                                                      child: Container(
                                                        margin: EdgeInsets.only(left : 5),
                                                        width: 100,
                                                        height: 110,
                                                        decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color: activeCategory == index
                                                                  ? primary
                                                                  : Colors.transparent,
                                                          width: activeCategory== index ? 2 : 0 ) ,
                                                          borderRadius: BorderRadius.circular(12),
                                                          color: Colors.black12.withOpacity(0.05),
                                                          boxShadow: [
                                                            BoxShadow(
                                                            color: Colors.grey.withOpacity(0.01),
                                                              blurRadius: 3,
                                                              spreadRadius: 10,
                                                        ),
                                                          ],
                                                        ),
                                                        child: Padding(
                                                          padding: EdgeInsets.only(left: 12,right: 12,bottom: 10,top: 10),
                                                          child: Column(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Container(
                                                                width: 50,
                                                                height: 50,
                                                                decoration: BoxDecoration(
                                                                  shape: BoxShape.circle,
                                                                  color: Colors.white,
                                                                ) ,
                                                                child: Center(
                                                                  child: ImageIcon(
                                                                    AssetImage(categories[index]['icon']),
                                                                    color: Colors.black87,
                                                                    size: 40,
                                                                  ),
                                                                ),
                                                              ),
                                                              Text(categories[index]['name'],
                                                                style:TextStyle(
                                                                  color: Colors.black87,
                                                                  fontWeight: FontWeight.bold,
                                                                  fontSize: 15,
                                                                ) ,
                                                              ),
                                                            ],
                                                          ),
                                                        ),

                                                      ),
                                                    ),
                                                  );
                                                }),
                                              ),
                                            ),

                                          ),
                                           Row(
                                             
                                             mainAxisAlignment: MainAxisAlignment.center,
                                               children: [
                                             Padding(
                                           padding: EdgeInsets.all(20),
                                               child: ElevatedButton(onPressed: () {

                                               },
                                                 child: Text("Nhập khoản chi"),
                                               ),
                                             ),
                                           ]),
                                        ],
                                       ),
                                       Column(
                                         children: <Widget>[
                                           TextField(
                                             decoration:
                                             InputDecoration(hintText: 'Personal Note'),
                                           ),
                                         ],
                                       )
                                     ],
                                   ),
                                 ),
                        ],

                              ),

                          ),

                        ],

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
