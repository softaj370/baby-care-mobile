import 'package:baby_care/core/utils/app_color.dart';
import 'package:baby_care/core/widgets/daily_info_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          spacing: 16,
          children: [
            Container(
              width: double.maxFinite,
              height: 80,
              decoration: BoxDecoration(border: Border.all(width: 1)),
              child: Text("Horizontal Calender date"),
            ),
            SizedBox(
              width: 300,
              child: AspectRatio(
                aspectRatio: 1,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/bubble-circle.png"),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 16,
                    children: [
                      Image.asset("assets/images/baby.png"),
                      Column(
                        children: [
                          Text(
                            "WEEK 14",
                            style: TextStyle(
                              height: 0,
                              color: AppColors.textColor,
                              fontSize: 28,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "Day 98",
                            style: TextStyle(
                              height: 0,
                              color: AppColors.textColor,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: Image.asset(
                "assets/images/add-button-shadow.png",
                height: 68,
              ),
            ),
            PhysicalModel(
              elevation: 20,
              shadowColor: AppColors.secondaryColor,
              color: Colors.transparent,
              child: AspectRatio(
                aspectRatio: 2 / 1,
                child: DailyInfoCard(
                  icon: CupertinoIcons.cloud,
                  title: "Daily Cards - Info",
                  detail: "Upload Image to start",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
