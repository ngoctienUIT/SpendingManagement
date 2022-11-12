import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spending_management/constants/function/list_categories.dart';

import 'day_month.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int activeDay = 20;
  late ScrollController _scrollControlled;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.05),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: header()),
          ],
        ),
      ),
    );
  }

  Widget getBody() {
    return const Scaffold();
  }

  Widget header() {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.01),
                  spreadRadius: 10,
                  blurRadius: 3,
                )
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 25),
              child: Column(
                children: [
                  Row(
                    children: const [
                      Text(
                        "Daily Transaction",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Spacer(),
                      Icon(
                        FontAwesomeIcons.magnifyingGlass,
                        size: 20,
                        color: Color.fromRGBO(180, 190, 190, 1),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Surplus",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Text(
                        "5.000.000 đ",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(
                      days.length,
                      (index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              activeDay = index;
                            });
                          },
                          child: Container(
                            width: (size.width - 40) / 7,
                            child: Column(
                              children: [
                                Text(
                                  days[index]['label'],
                                  style: const TextStyle(fontSize: 10),
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: activeDay == index
                                        ? Colors.cyan
                                        : Colors.transparent,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: activeDay == index
                                          ? Colors.cyan
                                          : Colors.black.withOpacity(0.1),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      days[index]['day'],
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: activeDay == index
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              children: [
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 80),
                  child: Text(
                    "Total",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      color: Colors.black.withOpacity(0.4),
                    ),
                  ),
                ),
                const Spacer(),
                const Text(
                  "\$ sum price",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 0),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              children: List.generate(
                days.length,
                (index) {
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: (size.width - 40) * 0.7,
                            child: Row(
                              children: [
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.1),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: Image.asset(
                                      categories[index]['icon'],
                                      width: 30,
                                      height: 30,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 15),
                                Container(
                                  width: (size.width - 90) * 0.5,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        categories[index]['name'],
                                        style: const TextStyle(
                                          fontSize: 15,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        "dateTime.now",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.black.withOpacity(0.5),
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: (size.width - 40) * 0.3,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: const [
                                Text(
                                  "price",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.green,
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 65, top: 8),
                        child: Divider(thickness: 0.8),
                      )
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
