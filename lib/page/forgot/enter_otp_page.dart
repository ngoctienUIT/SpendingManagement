import 'package:flutter/material.dart';
import 'package:spending_management/constants/app_colors.dart';
import 'package:spending_management/page/login/widget/custom_button.dart';
import 'package:spending_management/page/login/widget/input_text.dart';

class EnterOTPPage extends StatefulWidget {
  const EnterOTPPage({Key? key}) : super(key: key);

  @override
  State<EnterOTPPage> createState() => _EnterOTPPageState();
}

class _EnterOTPPageState extends State<EnterOTPPage> {
  final TextEditingController _otpController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whisperBackground,
      appBar: AppBar(
        backgroundColor: AppColors.whisperBackground,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.grey),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const Text(
                "Enter OTP",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              const Text(
                textAlign: TextAlign.center,
                "Don't worry! It happens. Please enter the email address with your account",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 50),
              inputText(
                hint: "OTP",
                validator: 2,
                controller: _otpController,
              ),
              const SizedBox(height: 30),
              customButton(
                action: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.pushNamed(context, '/reset');
                    return;
                  }
                },
                text: 'Submit',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
