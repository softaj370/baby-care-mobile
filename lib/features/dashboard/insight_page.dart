import 'package:baby_care/core/utils/app_color.dart';
import 'package:flutter/material.dart';

class InsightPage extends StatefulWidget {
  const InsightPage({super.key});

  @override
  State<InsightPage> createState() => _InsightPageState();
}

class _InsightPageState extends State<InsightPage> {
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
              width: double.maxFinite,
              height: 50,
              decoration: BoxDecoration(border: Border.all(width: 1)),
              child: Text("Tag List Container"),
            ),
            Container(
              width: double.maxFinite,
              decoration: BoxDecoration(border: Border.all(width: 1)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 4,
                children: [
                  Text(
                    "Most Popular",
                    style: TextStyle(
                      fontSize: 20,
                      color: AppColors.textColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Container(
                    height: 250,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.red),
                    ),
                    child: Text("Most Popular Card list horizontal"),
                  ),
                ],
              ),
            ),
            Container(
              width: double.maxFinite,
              decoration: BoxDecoration(border: Border.all(width: 1)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 4,
                children: [
                  Text(
                    "Reproductive Health 101",
                    style: TextStyle(
                      fontSize: 20,
                      color: AppColors.textColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Container(
                    height: 150,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.red),
                    ),
                    child: Text("Most Popular Card list horizontal"),
                  ),
                ],
              ),
            ),
            Container(
              width: double.maxFinite,
              decoration: BoxDecoration(border: Border.all(width: 1)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 4,
                children: [
                  Text(
                    "Top Picks",
                    style: TextStyle(
                      fontSize: 20,
                      color: AppColors.textColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Container(
                    height: 250,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.red),
                    ),
                    child: Text("Most Popular Card list horizontal"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
