import 'package:flutter/material.dart';

Widget itemOnBoarding(Map<String, String> item) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
    child: Column(
      children: [
        const SizedBox(height: 10),
        Text(
          item["title"]!,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        Text(
          item["content"]!,
          style: const TextStyle(fontSize: 16),
        ),
        // Image.asset(item["image"]!)
      ],
    ),
  );
}
