import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spending_management/constants/app_colors.dart';
import 'package:spending_management/firebase_options.dart';
import 'package:spending_management/page/forgot/forgot_page.dart';
import 'package:spending_management/page/forgot/success_page.dart';
import 'package:spending_management/page/login/login_page.dart';
import 'package:spending_management/page/main/home/home_page.dart';
import 'package:spending_management/page/main/main_page.dart';
import 'package:spending_management/page/onboarding/onboarding_page.dart';
import 'package:spending_management/page/signup/signup_page.dart';
import 'package:spending_management/page/signup/verify/verify_page.dart';
import 'package:spending_management/setting/bloc/setting_cubit.dart';
import 'package:spending_management/setting/bloc/setting_state.dart';
import 'package:spending_management/setting/localization/app_localizations_setup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final prefs = await SharedPreferences.getInstance();
  final int? language = prefs.getInt('language');
  final bool isDark = prefs.getBool("isDark") ?? false;
  final bool isFirstStart = prefs.getBool("firstStart") ?? true;
  runApp(MyApp(language: language, isDark: isDark, isFirstStart: isFirstStart));
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    this.language,
    required this.isDark,
    required this.isFirstStart,
  });
  final int? language;
  final bool isDark;
  final bool isFirstStart;

  @override
  Widget build(BuildContext context) {
    SharedPreferences.getInstance().then((value) {
      value.setBool("firstStart", false);
    });
    return MultiBlocProvider(
      providers: [
        BlocProvider<SettingCubit>(
          create: (_) => SettingCubit(language: language, isDark: isDark),
        ),
      ],
      child: BlocBuilder<SettingCubit, SettingState>(
        buildWhen: (previous, current) => previous != current,
        builder: (_, settingState) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            supportedLocales: AppLocalizationsSetup.supportedLocales,
            localizationsDelegates:
                AppLocalizationsSetup.localizationsDelegates,
            localeResolutionCallback:
                AppLocalizationsSetup.localeResolutionCallback,
            locale: settingState.locale,
            title: 'Spending Management',
            theme: settingState.isDark
                ? ThemeData(
                    brightness: Brightness.dark,
                    primarySwatch: Colors.blue,
                  )
                : ThemeData(
                    brightness: Brightness.light,
                    primarySwatch: Colors.blue,
                    scaffoldBackgroundColor: AppColors.whisperBackground,
                    bottomAppBarColor: AppColors.whisperBackground,
                    appBarTheme: const AppBarTheme(
                      backgroundColor: Colors.white,
                      iconTheme: IconThemeData(color: Colors.black),
                    ),
                  ),
            initialRoute: FirebaseAuth.instance.currentUser == null
                ? (isFirstStart ? "/" : '/login')
                : (FirebaseAuth.instance.currentUser!.emailVerified
                    ? '/main'
                    : '/verify'),
            routes: {
              '/': (context) => const OnboardingPage(),
              '/login': (context) => const LoginPage(),
              '/signup': (context) => const SignupPage(),
              '/home': (context) => const HomePage(),
              '/main': (context) => const MainPage(),
              '/forgot': (context) => const ForgotPage(),
              '/success': (context) => const SuccessPage(),
              '/verify': (context) => const VerifyPage()
            },
          );
        },
      ),
    );
  }
}
