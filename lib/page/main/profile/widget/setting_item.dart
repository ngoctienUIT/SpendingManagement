import 'package:flutter/material.dart';

Widget settingItem(
    {required String text,
    required Function action,
    required IconData icon,
    Color? color}) {
  return InkWell(
    onTap: () {
      action();
    },
    child: Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: color ?? Colors.black45,
            borderRadius: BorderRadius.circular(90),
          ),
          padding: const EdgeInsets.all(10),
          child: Icon(icon, color: Colors.white),
        ),
        const SizedBox(width: 10),
        Text(text, style: const TextStyle(fontSize: 18)),
        const Spacer(),
        const Icon(Icons.arrow_forward_ios_outlined)
      ],
    ),
  );
}
