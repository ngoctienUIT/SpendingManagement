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
import 'package:spending_management/page/signup/verify/input_wallet.dart';
import 'package:spending_management/page/signup/verify/verify_page.dart';
import 'package:spending_management/setting/bloc/setting_cubit.dart';
import 'package:spending_management/setting/bloc/setting_state.dart';
import 'package:spending_management/setting/localization/app_localizations_setup.dart';

bool loginMethod = false;
int? language;
bool isDark = false;
bool isFirstStart = true;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final prefs = await SharedPreferences.getInstance();
  language = prefs.getInt('language');
  isDark = prefs.getBool("isDark") ?? false;
  isFirstStart = prefs.getBool("firstStart") ?? true;
  loginMethod = prefs.getBool("login") ?? false;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
                : loginMethod
                    ? (FirebaseAuth.instance.currentUser!.emailVerified
                        ? '/main'
                        : '/verify')
                    : '/main',
            routes: {
              '/': (context) => const OnboardingPage(),
              '/login': (context) => const LoginPage(),
              '/signup': (context) => const SignupPage(),
              '/home': (context) => const HomePage(),
              '/main': (context) => const MainPage(),
              '/forgot': (context) => const ForgotPage(),
              '/success': (context) => const SuccessPage(),
              '/verify': (context) => const VerifyPage(),
              '/wallet': (context) => const InputWalletPage()
            },
          );
        },
      ),
    );
  }
}
