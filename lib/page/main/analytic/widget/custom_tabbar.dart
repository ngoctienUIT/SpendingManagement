import 'package:flutter/material.dart';
import 'package:spending_management/constants/app_styles.dart';

class CustomTabBar extends StatelessWidget {
  const CustomTabBar({Key? key, required this.controller}) : super(key: key);
  final TabController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(242, 243, 247, 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TabBar(
          controller: controller,
          labelColor: Colors.black87,
          labelStyle:
              const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          unselectedLabelColor: const Color.fromRGBO(45, 216, 198, 1),
          unselectedLabelStyle: AppStyles.p,
          isScrollable: false,
          indicatorColor: Colors.red,
          indicator: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          tabs: const [
            Tab(text: 'Week'),
            Tab(text: 'Month'),
            Tab(text: 'Year')
          ]),
    );
  }
}
