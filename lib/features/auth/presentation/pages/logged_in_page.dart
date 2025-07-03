import 'package:baby_care/core/utils/app_color.dart';
import 'package:baby_care/core/widgets/custom_button.dart';
import 'package:baby_care/core/widgets/page_layout_widget.dart';
import 'package:baby_care/screens/date_picker_page.dart';
import 'package:flutter/material.dart';

class LoggedInPage extends StatelessWidget {
  const LoggedInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageLayoutWidget(
        bottomChild: Container(
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadiusDirectional.vertical(
              top: Radius.circular(32),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 64),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 16,
              children: [
                CustomButton(
                  text: "I AM EXPECTING A BABY",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (builder) => DatePickerPage(),
                      ),
                    );
                  },
                  bgColor: Colors.white,
                  textColor: AppColors.primaryColor,
                ),
                CustomButton(
                  text: "I HAVE A CHILD",
                  onPressed: () {},
                  bgColor: Colors.white,
                  textColor: AppColors.primaryColor,
                ),
                CustomButton(
                  text: "JUST FOR INFORMATION",
                  onPressed: () {},
                  bgColor: Colors.white,
                  textColor: AppColors.primaryColor,
                ),
              ],
            ),
          ),
        ),
        children: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Center(
              child: Text(
                "Login Successful",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
