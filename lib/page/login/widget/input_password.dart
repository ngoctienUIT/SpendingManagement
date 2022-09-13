import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spending_management/constants/app_styles.dart';

Widget inputPassword(
    {required String hint,
    String? error,
    required TextEditingController controller,
    TextEditingController? password,
    required bool hide,
    required Function action}) {
  return TextFormField(
    controller: controller,
    obscureText: hide,
    style: AppStyles.p,
    validator: (value) {
      if (password != null &&
              password.text.toString() != controller.text.toString() ||
          password != null && value!.isEmpty) {
        return 'Enter a valid repassword!';
      }

      if (value!.isEmpty && password == null) {
        return 'Enter a valid password!';
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
      fillColor: Colors.white,
      hintText: hint,
      errorText: error,
      suffixIcon: IconButton(
        onPressed: () {
          action();
        },
        splashColor: Colors.transparent,
        icon: Icon(
          hide ? FontAwesomeIcons.eye : FontAwesomeIcons.eyeSlash,
          size: 20,
        ),
      ),
      contentPadding: const EdgeInsets.all(20),
    ),
  );
}
