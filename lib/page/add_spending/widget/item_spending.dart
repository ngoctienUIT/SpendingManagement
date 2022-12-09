import 'package:spending_management/constants/app_styles.dart';
import 'package:flutter/material.dart';

Widget itemSpending({
  required IconData icon,
  required String text,
  required Function action,
  Color? color,
}) {
  return Row(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Icon(icon, size: 35, color: color ?? Colors.grey),
      ),
      Expanded(
        child: InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {
            action();
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                const SizedBox(width: 10),
                Text(text, style: AppStyles.p),
                const Spacer(),
                const Icon(Icons.arrow_forward_ios_rounded),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}
