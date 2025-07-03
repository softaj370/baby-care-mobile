import 'dart:async';
import 'dart:developer';

import 'package:baby_care/core/services/local_storage_service.dart';
import 'package:baby_care/core/services/session_storage_service.dart';
import 'package:baby_care/core/utils/app_color.dart';
import 'package:baby_care/core/widgets/navigation_layout.dart';
import 'package:baby_care/screens/date_picker_page.dart';
import 'package:baby_care/web_login.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkSession();
  }

  void checkSession() async {
    final session = SessionStorageService.instance.getSession();
    log("here $session");
    if (session == null || session == "") {
      Timer.periodic(const Duration(seconds: 1), (timer) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const OdooLoginPage()),
        );
      });
    } else {
      Timer.periodic(const Duration(seconds: 1), (timer) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) =>
                LocalStorageService.instance.getSelectedDate() != null
                ? NavigationLayout()
                : const DatePickerPage(),
          ),
          (Route<dynamic> route) => false,
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
