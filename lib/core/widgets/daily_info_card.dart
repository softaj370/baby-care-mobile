import 'package:baby_care/core/constants/app_constance.dart';
import 'package:baby_care/core/services/session_storage_service.dart';
import 'package:baby_care/core/utils/app_color.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DailyInfoCard extends StatefulWidget {
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
  State<DailyInfoCard> createState() => _DailyInfoCardState();
}

class _DailyInfoCardState extends State<DailyInfoCard> {
  String htmlContent = '';

  final dio = Dio(BaseOptions(baseUrl: AppConstants.apiBaseUrl));
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchCardData();
  }


  Future<void> _fetchCardData() async {
    final response = await dio.post(
      AppConstants.callKw,
      data: {
        "jsonrpc": "2.0",
        "method": "call",
        "params": {
          "model": "baby.util.widget",
          "method": "get_daily_card",
          "args": [

          ],
          "kwargs": {}
        }
      },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          "Cookie": "session_id=${SessionStorageService.instance.getSession()}",
        },
      ),
    );

    if (response.statusCode == 200) {
    htmlContent = response.data['result']['daily_card']['content'] ?? '';
    } else {
      throw Exception('Failed to load baby info');
    }
  }


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
          Icon(widget.icon, size: 48, color: Colors.white),
          Text(
            widget.title,
            style: TextStyle(
              height: 0,
              color: AppColors.darkPrimaryColor,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            widget.detail,
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
