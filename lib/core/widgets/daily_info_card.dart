import 'package:baby_care/core/utils/app_color.dart';
import 'package:flutter/material.dart';

class DailyInfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String detail;

  const DailyInfoCard({
    super.key,
    required this.icon,
    required this.title,
    required this.detail,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.black.withAlpha(20)),
        borderRadius: BorderRadius.all(Radius.circular(20)),
        gradient: LinearGradient(
          colors: [AppColors.primaryColor, AppColors.secondaryColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      padding: EdgeInsets.symmetric(vertical: 32, horizontal: 24),
      child: Column(
        spacing: 8,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 48, color: Colors.white),
          Text(
            title,
            style: TextStyle(
              height: 0,
              color: AppColors.darkPrimaryColor,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            detail,
            style: TextStyle(
              height: 0,
              color: AppColors.darkPrimaryColor,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
