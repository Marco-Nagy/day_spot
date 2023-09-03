// ignore_for_file: library_private_types_in_public_api

import 'package:employees_attendance/Features/Authentication/presentation/provider/AuthenticationProvider.dart';
import 'package:employees_attendance/Features/Authentication/presentation/screens/login_screen.dart';
import 'package:employees_attendance/Features/Home/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, AuthProvider ap, child) {
        // ap.signOut();
        return ap.currentAuth == null
            ? const LoginScreen()
            : const HomeScreen();
      },
    );
  }
}
