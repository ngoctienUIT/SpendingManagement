import 'package:flutter/material.dart';
import 'package:spending_management/setting/localization/app_localizations.dart';

class CustomTabBar extends StatelessWidget {
  const CustomTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0),
      margin: const EdgeInsets.all(10),
      width: 220,
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
            child: Center(
              child: Text(AppLocalizations.of(context).translate('spending'),
                  style: const TextStyle(fontSize: 15)),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(0),
            width: 100,
            height: 30,
            child: Center(
              child: Text(AppLocalizations.of(context).translate('incomes'),
                  style: const TextStyle(fontSize: 15)),
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
    );
  }
}
