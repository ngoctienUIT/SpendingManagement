import 'package:spending_management/setting/localization/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:spending_management/constants/app_styles.dart';

class TextContinue extends StatelessWidget {
  const TextContinue({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          AppLocalizations.of(context).translate('or_continue_with'),
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
}
