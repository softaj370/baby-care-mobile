import 'package:baby_care/core/utils/app_color.dart';
import 'package:baby_care/core/widgets/most_popular_card.dart';
import 'package:baby_care/core/widgets/reproductive_card.dart';
import 'package:baby_care/core/widgets/top_pick_card.dart';
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
          spacing: 24,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.maxFinite,
              height: 50,
              decoration: BoxDecoration(border: Border.all(width: 1)),
              child: Text("Tag List Container"),
            ),
            SizedBox(
              width: double.maxFinite,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 12,
                children: [
                  Text(
                    "Most Popular",
                    style: TextStyle(
                      fontSize: 24,
                      color: AppColors.textColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 250,
                    child: ListView.separated(
                      separatorBuilder: (context, index) => SizedBox(width: 16),
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return MostPopularCard();
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: double.maxFinite,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 12,
                children: [
                  Text(
                    "Reproductive Health 101",
                    style: TextStyle(
                      fontSize: 24,
                      color: AppColors.textColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 250,
                    child: ListView.separated(
                      separatorBuilder: (context, index) => SizedBox(width: 16),
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return ReproductiveCard();
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: double.maxFinite,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 12,
                children: [
                  Text(
                    "Top Picks",
                    style: TextStyle(
                      fontSize: 24,
                      color: AppColors.textColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    separatorBuilder: (context, index) => SizedBox(height: 16),
                    scrollDirection: Axis.vertical,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return TopPickCard();
                    },
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
