import 'package:flutter/material.dart';
import 'package:spending_management/constants/app_colors.dart';
import 'package:spending_management/page/login/widget/custom_button.dart';
import 'package:spending_management/page/login/widget/input_password.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool hide = true;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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
                "Reset Password",
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
              const SizedBox(height: 20),
              inputPassword(
                action: () {
                  setState(() {
                    hide = !hide;
                  });
                },
                hint: "New Password",
                controller: _passwordController,
                hide: hide,
              ),
              const SizedBox(height: 20),
              inputPassword(
                action: () {
                  setState(() {
                    hide = !hide;
                  });
                },
                hint: "Confirm new Password",
                controller: _confirmPasswordController,
                password: _passwordController,
                hide: hide,
              ),
              const SizedBox(height: 30),
              customButton(
                action: () {
                  if (_formKey.currentState!.validate()) {
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
