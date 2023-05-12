import '../../../constants/app_styles.dart';
import 'package:flutter/material.dart';

Widget inputSpending({
  required IconData icon,
  required Color color,
  required TextEditingController controller,
  required String hintText,
  Function(String value)? action,
  TextInputAction? textInputAction,
  TextInputType? keyboardType,
  TextCapitalization textCapitalization = TextCapitalization.none,
}) {
  return Row(
    children: [
      Icon(icon, color: color, size: 30),
      const SizedBox(width: 10),
      Expanded(
        child: TextFormField(
          controller: controller,
          style: AppStyles.p,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          textCapitalization: textCapitalization,
          onFieldSubmitted: (value) {
            if (action != null) action(value);
          },
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
            hintStyle: AppStyles.p,
          ),
        ),
      ),
    ],
  );
}
