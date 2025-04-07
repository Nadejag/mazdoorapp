import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';


import 'apptheme.dart';
import 'onboardingscreen/welcomescreen.dart';

void main() async {
 WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mazdoor',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: const WelcomeScreen(),
    );
  }
}