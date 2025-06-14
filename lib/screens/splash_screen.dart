import 'dart:async';

import 'package:baby_care/core/utils/app_color.dart';
import 'package:baby_care/screens/agreement_page.dart';
import 'package:baby_care/screens/date_confirmation_page.dart';
import 'package:baby_care/screens/date_picker_page.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLoggedIn = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoggedIn = true;

    if (isLoggedIn) {
      Timer.periodic(const Duration(seconds: 1), (timer) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const AgreementPage()),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(color: Colors.white),
          child: Center(
            child: Text(
              "Baby Care App",
              style: TextStyle(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w500,
                fontSize: 24,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
