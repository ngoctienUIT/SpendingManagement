import 'package:flutter/material.dart';
import 'package:spending_management/constants/app_styles.dart';
import 'package:spending_management/setting/localization/app_localizations.dart';

class InputText extends StatelessWidget {
  const InputText({
    Key? key,
    required this.hint,
    this.error,
    required this.controller,
    required this.validator,
    this.inputType,
    this.textCapitalization = TextCapitalization.none,
  }) : super(key: key);

  final String hint;
  final String? error;
  final TextEditingController controller;
  final int validator;
  final TextInputType? inputType;
  final TextCapitalization textCapitalization;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: AppStyles.p,
      keyboardType: inputType,
      textCapitalization: textCapitalization,
      validator: (value) {
        if (validator == 0 &&
            (value!.isEmpty ||
                !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(value))) {
          return AppLocalizations.of(context).translate('enter_valid_email');
        } else if (validator == 1 && value!.isEmpty) {
          return AppLocalizations.of(context).translate('enter_valid_name');
        } else if (validator == 2 && value!.isEmpty) {
          return AppLocalizations.of(context).translate('enter_valid_OTP');
        }
        return null;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(width: 0, style: BorderStyle.none),
        ),
        hintStyle: AppStyles.p,
        filled: true,
        errorText: error,
        fillColor: Theme.of(context).colorScheme.background,
        hintText: hint,
        contentPadding: const EdgeInsets.all(20),
      ),
    );
  }
}
