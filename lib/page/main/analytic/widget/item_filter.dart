import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

Widget itemFilter({
  required String text,
  required Function(int) action,
  required List<String> list,
  required String value,
  String? content,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Row(
      children: [
        SizedBox(
          width: 70,
          child: Text(
            text,
            style: const TextStyle(fontSize: 16),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Container(
            height: 45,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(5),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton2<String>(
                hint: Center(
                    child: Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                )),
                underline: const SizedBox.shrink(),
                icon: const SizedBox.shrink(),
                isExpanded: true,
                // value: value,
                items: list.map(buildMenuItem).toList(),
                onChanged: (value) {
                  if (value != null) {
                    action(list.indexOf(value));
                  }
                },
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
      value: item,
      child: Center(
        child: Text(
          item,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
