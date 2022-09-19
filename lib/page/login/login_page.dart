import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:spending_management/constants/app_colors.dart';
import 'package:spending_management/page/login/bloc/login_bloc.dart';
import 'package:spending_management/page/login/login_form.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  DateTime? currentBackPressTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whisperBackground,
      body: WillPopScope(
        onWillPop: onWillPop,
        child: SafeArea(
          child: BlocProvider(
            create: (context) => LoginBloc(),
            child: const LoginForm(),
          ),
        ),
      ),
    );
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 3)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(msg: "Nhấn thêm lần nữa để thoát");
      return Future.value(false);
    }
    return Future.value(true);
  }
}
