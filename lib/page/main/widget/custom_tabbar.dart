import 'package:flutter/material.dart';

Widget customTabBar() {
  return Container(
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
  );
}
