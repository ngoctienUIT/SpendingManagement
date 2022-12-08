import 'package:flutter/material.dart';

Widget itemBottomTab({
  required String text,
  required int index,
  required int current,
  required IconData icon,
  required Function action,
  double? size,
}) {
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
          color: current == index
              ? const Color.fromRGBO(173, 149, 121, 1)
              : Colors.grey,
          size: size,
        ),
        const SizedBox(height: 5),
        Text(
          text,
          style: TextStyle(
            color: current == index
                ? const Color.fromRGBO(173, 149, 121, 1)
                : Colors.grey,
          ),
        )
      ],
    ),
  );
}
