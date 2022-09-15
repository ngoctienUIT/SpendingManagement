import 'package:flutter/material.dart';
import 'package:spending_management/constants/app_colors.dart';
import 'package:spending_management/page/login/widget/custom_button.dart';

class SuccessPage extends StatelessWidget {
  const SuccessPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whisperBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
          child: Column(
            children: [
              const Text(
                "Success",
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                textAlign: TextAlign.center,
                "Vui lòng kiểm tra email và thực hiện thay đổi mật khẩu mới!",
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20),
              Image.asset(
                'assets/images/gmail.png',
                width: 120,
              ),
              const SizedBox(height: 20),
              customButton(
                text: 'Go to Login',
                action: () {
                  Navigator.pushReplacementNamed(context, '/login');
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
