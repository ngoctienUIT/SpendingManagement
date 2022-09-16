import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:spending_management/firebase_options.dart';
import 'package:spending_management/page/forgot/forgot_page.dart';
import 'package:spending_management/page/forgot/success_page.dart';
import 'package:spending_management/page/login/login_page.dart';
import 'package:spending_management/page/main/home/home_page.dart';
import 'package:spending_management/page/main/main_page.dart';
import 'package:spending_management/page/onboarding/onboarding_page.dart';
import 'package:spending_management/page/signup/signup_page.dart';
import 'package:spending_management/page/signup/verify/verify_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: FirebaseAuth.instance.currentUser == null
          ? "/"
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
  }
}
