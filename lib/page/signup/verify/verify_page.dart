import 'dart:async';
import 'package:spending_management/constants/function/on_will_pop.dart';
import 'package:spending_management/constants/function/route_function.dart';
import 'package:spending_management/page/signup/verify/input_wallet.dart';
import 'package:spending_management/setting/localization/app_localizations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spending_management/constants/app_colors.dart';
import 'package:spending_management/constants/app_styles.dart';

class VerifyPage extends StatefulWidget {
  const VerifyPage({Key? key}) : super(key: key);

  @override
  State<VerifyPage> createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  bool isEmailVerify = false;
  bool canResendEmail = false;
  Timer? timer;
  DateTime? currentBackPressTime;

  @override
  void initState() {
    super.initState();
    isEmailVerify = FirebaseAuth.instance.currentUser!.emailVerified;
    if (!isEmailVerify) {
      sendVerificationEmail();
      timer = Timer.periodic(const Duration(seconds: 3), (timer) {
        checkEmailVerified();
      });
    }
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerify = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (isEmailVerify) {
      timer!.cancel();
    }
  }

  @override
  void dispose() {
    if (timer != null) {
      timer!.cancel();
    }
    super.dispose();
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      await user!.sendEmailVerification();
      setState(() => canResendEmail = false);
      Future.delayed(const Duration(seconds: 5));
      setState(() => canResendEmail = true);
    } catch (_) {}
  }

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
                  AppLocalizations.of(context).translate("verify_email"),
                  style: const TextStyle(
                    fontSize: 25,
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  textAlign: TextAlign.center,
                  isEmailVerify
                      ? AppLocalizations.of(context)
                          .translate('congratulation_your_email_verified')
                      : AppLocalizations.of(context).translate(
                          'please_check_your_email_verify_your_email'),
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 20),
                Image.asset(
                  isEmailVerify
                      ? 'assets/images/email.png'
                      : 'assets/images/gmail.png',
                  width: 120,
                ),
                const SizedBox(height: 20),
                if (isEmailVerify)
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          createRoute(screen: const InputWalletPage()),
                        );
                      },
                      icon: const Icon(FontAwesomeIcons.house),
                      label: Text(
                        AppLocalizations.of(context).translate("go_to_home"),
                        style: AppStyles.p,
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.buttonLogin,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                if (!isEmailVerify)
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton.icon(
                      onPressed: canResendEmail
                          ? () {
                              sendVerificationEmail();
                            }
                          : null,
                      icon: const Icon(FontAwesomeIcons.envelope),
                      label: Text(
                          AppLocalizations.of(context)
                              .translate("resend_email"),
                          style: AppStyles.p),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.buttonLogin,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                if (!isEmailVerify) const SizedBox(height: 10),
                if (!isEmailVerify)
                  TextButton(
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/login', (route) => false);
                    },
                    child: Text(
                      AppLocalizations.of(context).translate("cancel"),
                      style: AppStyles.p,
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
