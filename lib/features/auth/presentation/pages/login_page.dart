import 'package:baby_care/core/utils/app_color.dart';
import 'package:baby_care/core/widgets/image_button.dart';
import 'package:baby_care/core/widgets/page_layout_widget.dart';
import 'package:baby_care/features/auth/presentation/pages/logged_in_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: PageLayoutWidget(
          bottomChild: Container(
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadiusDirectional.vertical(
                top: Radius.circular(32),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 32),
              child: Column(
                spacing: 24,
                children: [
                  Text(
                    "Login or Sign up here:",
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.textColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 16,
                    children: [
                      ImageButton(
                        imagePath: "assets/images/google-icon.png",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (builder) => LoggedInPage(),
                            ),
                          );
                        },
                      ),
                      ImageButton(
                        imagePath: "assets/images/apple-icon.png",
                        onTap: () {},
                      ),
                      ImageButton(
                        imagePath: "assets/images/mail-icon.png",
                        onTap: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          children: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 16,
                children: [
                  Text(
                    "Never lose your data",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                  ),
                  Text(
                    "Create an account to sync your data, even if you change your device",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.grayTextColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
