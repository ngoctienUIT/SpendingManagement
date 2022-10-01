import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:spending_management/constants/app_styles.dart';
import 'package:spending_management/constants/function/loading_animation.dart';
import 'package:spending_management/models/user.dart';
import 'package:spending_management/page/login/widget/custom_button.dart';
import 'package:spending_management/page/login/widget/input_password.dart';
import 'package:spending_management/page/login/widget/input_text.dart';
import 'package:spending_management/page/signup/bloc/signup_bloc.dart';
import 'package:spending_management/page/signup/bloc/signup_event.dart';
import 'package:spending_management/page/signup/bloc/singup_state.dart';
import 'package:spending_management/page/signup/gender_widget.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({Key? key}) : super(key: key);

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();
  DateTime birthday = DateTime.now();
  bool hide = true;
  bool gender = true;

  @override
  void dispose() {
    _nameController.dispose();
    _userController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(
      builder: (context, state) {
        if (state is SignupSuccessState) {
          Navigator.pop(context);
          SchedulerBinding.instance.addPostFrameCallback((_) {
            var snackBar =
                const SnackBar(content: Text('Tạo tài khoản thành công'));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            Future.delayed(const Duration(seconds: 3), () {
              Navigator.pushReplacementNamed(context, "/verify");
            });
          });
        }

        if (state is SignupErrorState) {
          Navigator.pop(context);
          SchedulerBinding.instance.addPostFrameCallback((_) {
            var snackBar =
                const SnackBar(content: Text('Không thể tạo tài khoản'));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          });
        }

        return Form(
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
                  Row(
                    children: [
                      const Spacer(),
                      genderWidget(
                          currentGender: gender,
                          gender: true,
                          action: () {
                            if (!gender) {
                              setState(() {
                                gender = true;
                              });
                            }
                          }),
                      const Spacer(),
                      genderWidget(
                          currentGender: gender,
                          gender: false,
                          action: () {
                            if (gender) {
                              setState(() {
                                gender = false;
                              });
                            }
                          }),
                      const Spacer(),
                    ],
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
                      padding: const EdgeInsets.only(right: 10, left: 20),
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
                    action: () {
                      setState(() {
                        hide = !hide;
                      });
                    },
                    hint: "Password",
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
                    hint: "Confirm Password",
                    controller: _confirmPasswordController,
                    password: _passwordController,
                    hide: hide,
                  ),
                  const SizedBox(height: 20),
                  customButton(
                    action: () {
                      if (_formKey.currentState!.validate()) {
                        loadingAnimation(context);
                        BlocProvider.of<SignupBloc>(context).add(
                          SignupEmailPasswordEvent(
                            email: _userController.text.trim(),
                            password: _passwordController.text,
                            user: User(
                              name: _nameController.text.trim(),
                              birthday:
                                  DateFormat("dd/MM/yyyy").format(birthday),
                              gender: gender,
                              avatar: "",
                            ),
                          ),
                        );
                        return;
                      }
                    },
                    text: 'Sign Up',
                  ),
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
        );
      },
    );
  }
}
