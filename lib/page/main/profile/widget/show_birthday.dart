import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Widget showBirthday(DateTime date) {
  return Container(
    width: double.infinity,
    height: 45,
    padding: const EdgeInsets.symmetric(vertical: 10),
    decoration: const BoxDecoration(
      border: Border(
        bottom: BorderSide(color: Colors.grey, width: 1),
      ),
    ),
    child: Text(
      DateFormat("dd/MM/yyyy").format(date),
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
