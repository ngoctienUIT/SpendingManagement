import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:spending_management/constants/app_colors.dart';
import 'package:spending_management/constants/app_styles.dart';
import 'package:spending_management/page/login/widget/custom_button.dart';
import 'package:spending_management/page/login/widget/input_password.dart';
import 'package:spending_management/page/login/widget/input_text.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  DateTime birthday = DateTime.now();
  bool hide = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whisperBackground,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: Column(
                children: [
                  const Text(
                    "Hello New User!",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Welcome to App",
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 50),
                  inputText(
                    hint: "Name",
                    validator: 1,
                    controller: _nameController,
                    inputType: TextInputType.name,
                  ),
                  const SizedBox(height: 20),
                  inputText(
                    hint: "Username",
                    validator: 0,
                    controller: _userController,
                    inputType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 20),
                  InkWell(
                    onTap: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: birthday,
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                      );
                      if (picked != null && picked != birthday) {
                        setState(() {
                          birthday = picked;
                        });
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      alignment: Alignment.centerLeft,
                      width: double.infinity,
                      height: 57,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Text(
                            DateFormat("dd/MM/yyyy").format(birthday),
                            style: AppStyles.p,
                          ),
                          const Spacer(),
                          const Icon(
                            Icons.calendar_month_rounded,
                            size: 25,
                            color: Colors.grey,
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  inputPassword(
                      hint: "Password",
                      controller: _passwordController,
                      hide: hide,
                      action: () {
                        setState(() {
                          hide = !hide;
                        });
                      }),
                  const SizedBox(height: 20),
                  inputPassword(
                      hint: "Repassword",
                      controller: _repasswordController,
                      password: _passwordController,
                      hide: hide,
                      action: () {
                        setState(() {
                          hide = !hide;
                        });
                      }),
                  const SizedBox(height: 20),
                  customButton(
                      text: 'Sign Up',
                      action: () {
                        if (_formKey.currentState!.validate()) {
                          return;
                        }
                      }),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Have an account?",
                        style: AppStyles.p,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/login');
                        },
                        child: Text(
                          "Login now",
                          style: AppStyles.p,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
