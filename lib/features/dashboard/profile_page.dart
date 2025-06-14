import 'package:baby_care/core/utils/app_color.dart';
import 'package:baby_care/core/widgets/daily_info_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          spacing: 16,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 68,
              decoration: BoxDecoration(border: Border.all(width: 1)),
              child: Row(
                spacing: 8,
                children: [
                  AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(width: 1),
                        shape: BoxShape.circle,
                      ),
                      child: Center(child: Text("photo")),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(border: Border.all(width: 1)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Text("Welcome"), Text("Full Name")],
                    ),
                  ),
                ],
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
