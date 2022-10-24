import 'package:flutter/material.dart';
import 'package:spending_management/constants/function/get_date.dart';

Widget showDate({
  required String date,
  required int index,
  required DateTime now,
  required Function(String, DateTime) action,
}) {
  return SizedBox(
    width: double.infinity,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: () {
            if (index == 0) {
              now = now.subtract(const Duration(days: 6));
              action(getWeek(now), now);
            } else if (index == 1) {
              now = DateTime(now.year, now.month - 1);
              action(getMonth(now), now);
            } else {
              now = DateTime(now.year - 1);
              action(getYear(now), now);
            }
          },
          child: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        Text(
          date,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        TextButton(
          onPressed: () {
            if (index == 0) {
              now = now.add(const Duration(days: 6));
              action(getWeek(now), now);
            } else if (index == 1) {
              now = DateTime(now.year, now.month + 1);
              action(getMonth(now), now);
            } else {
              now = DateTime(now.year + 1);
              action(getYear(now), now);
            }
          },
          child: const Icon(Icons.arrow_forward_ios_rounded),
        )
      ],
    ),
  );
}
