import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spending_management/constants/app_styles.dart';
import 'package:spending_management/constants/function/loading_animation.dart';
import 'package:spending_management/page/login/bloc/login_bloc.dart';
import 'package:spending_management/page/login/bloc/login_event.dart';
import 'package:spending_management/page/login/bloc/login_state.dart';
import 'package:spending_management/page/login/widget/custom_button.dart';
import 'package:spending_management/page/login/widget/input_password.dart';
import 'package:spending_management/page/login/widget/input_text.dart';
import 'package:spending_management/page/login/widget/text_continue.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool hide = true;

  @override
  void dispose() {
    _userController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        if (state is LoginSuccessState) {
          Navigator.pop(context);
          SchedulerBinding.instance.addPostFrameCallback((_) {
            if (state.social == Social.email &&
                !FirebaseAuth.instance.currentUser!.emailVerified) {
              Navigator.pushReplacementNamed(context, "/verify");
            } else {
              Navigator.pushReplacementNamed(context, "/main");
            }
          });
        }

        if (state is LoginErrorState) {
          Navigator.pop(context);
          SchedulerBinding.instance.addPostFrameCallback((_) {
            var snackBar = const SnackBar(
                content: Text('Tài khoản hoặc mật khẩu không đúng'));
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
                    "Hello Again!",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Welcome back you've been missed",
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 50),
                  inputText(
                    hint: "Username",
                    validator: 0,
                    controller: _userController,
                    inputType: TextInputType.emailAddress,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/forgot');
                          },
                          child: const Text("Forgot Password?")),
                    ],
                  ),
                  const SizedBox(height: 20),
                  customButton(
                    action: () {
                      if (_formKey.currentState!.validate()) {
                        loadingAnimation(context);
                        BlocProvider.of<LoginBloc>(context).add(
                          LoginWithEmailPasswordEvent(
                            email: _userController.text.trim(),
                            password: _passwordController.text.trim(),
                          ),
                        );
                        return;
                      }
                    },
                    text: 'Sign In',
                  ),
                  const SizedBox(height: 30),
                  textContinue(),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 50,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              BlocProvider.of<LoginBloc>(context)
                                  .add(LoginWithGoogleEvent());
                            },
                            icon: Image.asset(
                              "assets/logo/google_logo.png",
                              width: 20,
                            ),
                            label: const Text(
                              "Google",
                              style: TextStyle(
                                  color: Color.fromRGBO(125, 125, 125, 1)),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 30),
                      Expanded(
                        child: SizedBox(
                          height: 50,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              BlocProvider.of<LoginBloc>(context)
                                  .add(LoginWithFacebookEvent());
                            },
                            icon: const Icon(FontAwesomeIcons.facebook),
                            label: const Text(
                              "Facebook",
                              style: TextStyle(color: Colors.white),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromRGBO(66, 103, 178, 1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Do not have an account?",
                        style: AppStyles.p,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/signup');
                        },
                        child: Text(
                          "Register now",
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
