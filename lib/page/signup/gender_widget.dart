import 'package:flutter/material.dart';
import 'package:spending_management/constants/app_colors.dart';
import 'package:spending_management/constants/app_styles.dart';

Widget genderWidget(
    {required bool currentGender,
    required bool gender,
    required Function action}) {
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
            gender ? 'Male' : 'Female',
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
