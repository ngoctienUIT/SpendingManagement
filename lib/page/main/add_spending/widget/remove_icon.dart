import 'package:flutter/material.dart';

Widget removeIcon({required Function action, Color? background, Color? color}) {
  return InkWell(
    onTap: () {
      action();
    },
    child: Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(90),
        color: background ?? Colors.grey,
      ),
      child: Icon(Icons.close, size: 15, color: color),
    ),
  );
}
