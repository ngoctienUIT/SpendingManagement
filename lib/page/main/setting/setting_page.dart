import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spending_management/page/main/setting/change_pass_word_page.dart';
import 'package:spending_management/page/main/setting/profile_page.dart';
import 'package:spending_management/setting/bloc/setting_cubit.dart';
import 'package:spending_management/setting/localization/app_localizations.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool darkMode = false;
  bool loginMethod = false;
  int language = 0;
  bool valNotify2 = false;
  bool valNotify3 = false;

  @override
  void initState() {
    SharedPreferences.getInstance().then((value) {
      setState(() {
        language = value.getInt('language') ??
            (Platform.localeName.split('_')[0] == "vi" ? 0 : 1);
        darkMode = value.getBool("isDark") ?? false;
        loginMethod = value.getBool("login") ?? false;
      });
    });
    super.initState();
  }

  onChangeFunction1(bool value) async {
    BlocProvider.of<SettingCubit>(context).changeTheme();
    setState(() => darkMode = value);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDark', darkMode);
  }

  onChangeFunction2(bool newValue2) {
    setState(() {
      valNotify2 = newValue2;
    });
  }

  onChangeFunction3(bool newValue3) {
    setState(() {
      valNotify3 = newValue3;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
        child: ListView(
          children: [
            const SizedBox(height: 10, width: 50),
            Row(
              children: [
                Text(
                  AppLocalizations.of(context).translate('setting'),
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            Row(
              children: [
                const Icon(Icons.person, color: Colors.blue),
                const SizedBox(width: 10),
                Text(
                  AppLocalizations.of(context).translate('account'),
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold),
                )
              ],
            ),
            const Divider(height: 20, thickness: 2),
            const SizedBox(height: 10),
            if (loginMethod)
              buildAccountOption2(
                Icons.password_outlined,
                const Color(0xff000000),
                context,
                AppLocalizations.of(context).translate('change_password'),
              ),
            buildAccountOption1(
              Icons.wallet,
              const Color(0xff050832),
              context,
              AppLocalizations.of(context).translate('edit_profile'),
            ),
            buildAccountOption(
              Icons.language_rounded,
              const Color(0xff0a439a),
              context,
              AppLocalizations.of(context).translate('language'),
            ),
            const SizedBox(height: 40),
            Row(
              children: [
                const Icon(Icons.volume_down, color: Colors.blue),
                const SizedBox(width: 10),
                Text(
                  AppLocalizations.of(context).translate('notifications'),
                  //"Notifications",
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold),
                )
              ],
            ),
            const Divider(height: 20, thickness: 1),
            const SizedBox(height: 10),
            buildNotificationsOptions(
              Icons.dark_mode,
              const Color(0xFF642ef3),
              AppLocalizations.of(context).translate('dark_mode'),
              darkMode,
              onChangeFunction1,
            ),
            buildNotificationsOptions(
              Icons.notifications_active,
              Colors.black,
              AppLocalizations.of(context).translate('account_active'),
              valNotify2,
              onChangeFunction2,
            ),
            // buildNotificationsOptions(isIcon1,"Opportunity", valNotify3,onChangeFunction3),
            const SizedBox(height: 80),
            Center(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  await GoogleSignIn().signOut();
                  await FacebookAuth.instance.logOut();
                  if (!mounted) return;
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/', (route) => false);
                },
                child: Text(
                  AppLocalizations.of(context).translate('logout'),
                  style: const TextStyle(
                    fontSize: 16,
                    letterSpacing: 2.2,
                    color: Colors.black,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildNotificationsOptions(IconData icon, Color color, String title,
      bool value, Function onChangedMethod) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color),
          const SizedBox(width: 10),
          Text(
            title,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w100,
                color: Colors.grey[1]),
          ),
          Transform.scale(
            scale: 0.7,
            child: CupertinoSwitch(
              activeColor: Colors.blue,
              trackColor: Colors.grey,
              value: value,
              onChanged: (bool newValue) {
                onChangedMethod(newValue);
              },
            ),
          )
        ],
      ),
    );
  }

  Widget buildAccountOption(
    IconData icon,
    Color color,
    BuildContext context,
    String title,
  ) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(title),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextButton(
                      onPressed: () {
                        changeLanguage(1);
                      },
                      child: const Text("English"),
                    ),
                    TextButton(
                      onPressed: () {
                        changeLanguage(0);
                      },
                      child: const Text("Vietnamese"),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("close"),
                  )
                ],
              );
            });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(icon, color: color),
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.grey[10],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, color: Colors.grey)
          ],
        ),
      ),
    );
  }

  Widget buildAccountOption1(
    IconData icon,
    Color color,
    BuildContext context,
    String title,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SettingProfile(),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(icon, color: color),
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.grey[10],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, color: Colors.grey)
          ],
        ),
      ),
    );
  }

  Widget buildAccountOption2(
      IconData icon,
      Color color,
      BuildContext context,
      String title,
      ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ChangePassWord(),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(icon, color: color),
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.grey[10],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, color: Colors.grey)
          ],
        ),
      ),
    );
  }

  Future changeLanguage(int lang) async {
    if (lang != language) {
      if (lang == 0) {
        BlocProvider.of<SettingCubit>(context).toVietnamese();
      } else {
        BlocProvider.of<SettingCubit>(context).toEnglish();
      }
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('language', lang);
      if (!mounted) return;
      setState(() => language = lang);
    }

    if (!mounted) return;
    Navigator.pop(context);
  }
}
