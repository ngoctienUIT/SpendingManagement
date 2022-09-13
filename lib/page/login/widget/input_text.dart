import 'package:flutter/material.dart';
import 'package:spending_management/constants/app_styles.dart';

Widget inputText(
    {required String hint,
    String? error,
    required TextEditingController controller,
    required int validator,
    TextInputType? inputType}) {
  return TextFormField(
    controller: controller,
    style: AppStyles.p,
    keyboardType: inputType,
    validator: (value) {
      if (validator == 0 &&
          (value!.isEmpty ||
              !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                  .hasMatch(value))) {
        return 'Enter a valid email!';
      } else if (validator == 1 && value!.isEmpty) {
        return 'Enter a valid name';
      }
      return null;
    },
    decoration: InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(
          width: 0,
          style: BorderStyle.none,
        ),
      ),
      hintStyle: AppStyles.p,
      filled: true,
      errorText: error,
      fillColor: Colors.white,
      hintText: hint,
      contentPadding: const EdgeInsets.all(20),
    ),
  );
}
