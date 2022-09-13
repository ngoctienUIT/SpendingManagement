import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spending_management/constants/app_colors.dart';
import 'package:spending_management/page/login/bloc/login_bloc.dart';
import 'package:spending_management/page/login/login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whisperBackground,
      body: SafeArea(
        child: BlocProvider(
          create: (context) => LoginBloc(),
          child: const LoginForm(),
        ),
      ),
    );
  }
}
