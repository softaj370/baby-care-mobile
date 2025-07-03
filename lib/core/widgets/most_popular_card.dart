import 'package:baby_care/core/utils/app_color.dart';
import 'package:flutter/material.dart';

class MostPopularCard extends StatelessWidget {
  const MostPopularCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        color: AppColors.lightSecondaryColor,
        image: DecorationImage(
          alignment: AlignmentGeometry.xy(1, 0),
          image: AssetImage("assets/images/paint-girl.png"),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.black26,
                  ),
                  child: Text(
                    "New",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Text(
                  "Pre-conception Document",
                  style: TextStyle(
                    fontSize: 36,
                    height: 0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  "Emima Chhetri, MD \n OB-GYN",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
