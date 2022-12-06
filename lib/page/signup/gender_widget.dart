import 'package:spending_management/setting/localization/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:spending_management/constants/app_colors.dart';
import 'package:spending_management/constants/app_styles.dart';

class GenderWidget extends StatelessWidget {
  const GenderWidget({
    Key? key,
    required this.action,
    required this.gender,
    required this.currentGender,
  }) : super(key: key);
  final bool currentGender;
  final bool gender;
  final Function action;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: () {
        action();
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: gender == currentGender
              ? Colors.white24
              : AppColors.whisperBackground,
          border: Border.all(
            color: gender == currentGender
                ? Colors.black12
                : AppColors.whisperBackground,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Text(
              gender
                  ? AppLocalizations.of(context).translate('male')
                  : AppLocalizations.of(context).translate('female'),
              style: AppStyles.p,
            ),
            const SizedBox(height: 10),
            Image.asset(
              gender ? 'assets/images/male.png' : 'assets/images/female.png',
              width: 100,
            ),
          ],
        ),
      ),
    );
  }
}
