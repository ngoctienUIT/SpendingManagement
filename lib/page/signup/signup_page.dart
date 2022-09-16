import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spending_management/constants/app_colors.dart';
import 'package:spending_management/constants/onWillPop.dart';
import 'package:spending_management/page/signup/bloc/signup_bloc.dart';
import 'package:spending_management/page/signup/signup_form.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  DateTime? currentBackPressTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whisperBackground,
      body: WillPopScope(
        onWillPop: () => onWillPop(currentBackPressTime: currentBackPressTime),
        child: SafeArea(
          child: BlocProvider(
            create: (context) => SignupBloc(),
            child: const SignupForm(),
          ),
        ),
      ),
    );
  }
}
