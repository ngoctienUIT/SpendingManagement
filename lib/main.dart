import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:spending_management/firebase_options.dart';
import 'package:spending_management/page/login/login_page.dart';
import 'package:spending_management/page/main/home/home_page.dart';
import 'package:spending_management/page/onboarding/onboarding_page.dart';
import 'package:spending_management/page/signup/signup_page.dart';

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
      initialRoute: "/",
      routes: {
        '/': (context) => const OnboardingPage(),
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignupPage(),
        '/home': (context) => const HomePage()
      },
      // home: const OnboardingPage(),
    );
  }
}
