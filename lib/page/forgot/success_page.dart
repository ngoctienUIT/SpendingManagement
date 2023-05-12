import '../../../constants/function/on_will_pop.dart';
import '../../../setting/localization/app_localizations.dart';
import 'package:flutter/material.dart';
import '../../../page/login/widget/custom_button.dart';

class SuccessPage extends StatefulWidget {
  const SuccessPage({Key? key}) : super(key: key);

  @override
  State<SuccessPage> createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage> {
  DateTime? currentBackPressTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () => onWillPop(
          action: (now) => currentBackPressTime = now,
          currentBackPressTime: currentBackPressTime,
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
            child: Column(
              children: [
                Text(
                  AppLocalizations.of(context).translate('success'),
                  style: const TextStyle(
                    fontSize: 25,
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  textAlign: TextAlign.center,
                  AppLocalizations.of(context)
                      .translate('check_your_email_make_password_change'),
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 20),
                Image.asset(
                  'assets/images/gmail.png',
                  width: 120,
                ),
                const SizedBox(height: 20),
                customButton(
                  text: AppLocalizations.of(context).translate('go_to_login'),
                  action: () {
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
