import 'package:flutter/material.dart';
import 'package:spending_management/constants/app_styles.dart';

Widget textContinue() {
  return Row(
    children: [
      const Expanded(
        child: Divider(
          color: Colors.black,
          endIndent: 10,
          indent: 20,
        ),
      ),
      Text(
        "Or continue with",
        style: AppStyles.p,
      ),
      const Expanded(
        child: Divider(
          color: Colors.black,
          endIndent: 20,
          indent: 10,
        ),
      ),
    ],
  );
}
