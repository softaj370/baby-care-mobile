import 'package:baby_care/core/utils/app_color.dart';
import 'package:baby_care/core/widgets/custom_button.dart';
import 'package:baby_care/core/widgets/navigation_layout.dart';
import 'package:baby_care/core/widgets/page_layout_widget.dart';
import 'package:flutter/material.dart';

class DateConfirmationPage extends StatelessWidget {
  final String title;
  final DateTime date;

  const DateConfirmationPage({
    super.key,
    required this.title,
    required this.date,
  });

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
                  text: "Yes, that ‘s right",
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (builder) => NavigationLayout(),
                      ),

                      (Route<dynamic> route) => false,
                    );
                  },
                  bgColor: Colors.white,
                  textColor: AppColors.primaryColor,
                ),
                CustomButton(
                  text: "No, Update date",
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  bgColor: Colors.white,
                  textColor: AppColors.primaryColor,
                ),
                CustomButton(
                  text: "No",
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
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                children: [
                  Text(
                    title,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                  ),
                  SizedBox(
                    width: 300,
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              "assets/images/bubble-circle.png",
                            ),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "October",
                              style: TextStyle(
                                height: 0,
                                color: AppColors.textColor,
                                fontSize: 48,
                                fontWeight: FontWeight.w500,
                                shadows: [
                                  Shadow(
                                    offset: Offset(0, 4),
                                    blurRadius: 4,
                                    color: Colors.black.withAlpha(25),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              date.day.toString(),
                              style: TextStyle(
                                height: 0,
                                color: AppColors.textColor,
                                fontSize: 74,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
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
