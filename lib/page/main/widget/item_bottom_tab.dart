import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget itemBottomTab(
    {required String text,
    required int index,
    required int current,
    required IconData icon,
    required Function action,
    double? size}) {
  return MaterialButton(
    minWidth: 40,
    onPressed: () {
      action();
    },
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: current == index ? Colors.red : Colors.grey,
          size: size,
        ),
        Text(
          text,
          style: TextStyle(color: current == index ? Colors.red : Colors.grey),
        )
      ],
    ),
  );
}
