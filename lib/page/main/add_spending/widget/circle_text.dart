import 'package:flutter/material.dart';

Widget circleText({required String text, required Color color}) {
  return Container(
    width: 40,
    height: 40,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(90),
    ),
    child: Center(
      child: Text(
        text.toUpperCase(),
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    ),
  );
}
