import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spending_management/constants/app_colors.dart';
import 'package:spending_management/page/signup/bloc/signup_bloc.dart';
import 'package:spending_management/page/signup/signup_form.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whisperBackground,
      body: SafeArea(
        child: BlocProvider(
          create: (context) => SignupBloc(),
          child: const SignupForm(),
        ),
      ),
    );
  }
}
