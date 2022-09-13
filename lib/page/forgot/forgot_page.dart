import 'package:flutter/material.dart';
import 'package:spending_management/constants/app_colors.dart';
import 'package:spending_management/page/login/widget/custom_button.dart';
import 'package:spending_management/page/login/widget/input_text.dart';

class ForgotPage extends StatefulWidget {
  const ForgotPage({Key? key}) : super(key: key);

  @override
  State<ForgotPage> createState() => _ForgotPageState();
}

class _ForgotPageState extends State<ForgotPage> {
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
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
                "Forgot Password?",
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
                hint: "Username",
                validator: 0,
                controller: _emailController,
                inputType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 30),
              customButton(
                action: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.pushNamed(context, '/otp');
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
