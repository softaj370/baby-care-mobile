import 'package:baby_care/core/utils/app_color.dart';
import 'package:flutter/material.dart';

class ReproductiveCard extends StatelessWidget {
  const ReproductiveCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        color: AppColors.lightSecondaryColor,
        image: DecorationImage(
          image: AssetImage("assets/images/paint-girl.png"),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            "Early Symptoms of Pregnancy",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
