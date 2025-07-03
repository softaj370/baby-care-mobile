import 'package:baby_care/core/utils/app_color.dart';
import 'package:flutter/material.dart';

class TopPickCard extends StatelessWidget {
  const TopPickCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 16,
      children: [
        Container(
          height: 80,
          width: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(
              fit: BoxFit.fitWidth,
              image: AssetImage("assets/images/article-image.png"),
            ),
          ),
        ),

        Column(
          spacing: 4,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Pre-conception Document",
              style: TextStyle(
                fontSize: 20,
                height: 0,
                fontWeight: FontWeight.w500,
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 8,
              children: [
                Text(
                  "Sep 17, 2020",
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.grayTextColor,
                  ),
                ),
                Container(
                  height: 5,
                  width: 5,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.grayTextColor,
                  ),
                ),
                Text(
                  "5 min read",
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.grayTextColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
