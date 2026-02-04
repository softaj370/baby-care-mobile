import 'package:baby_care/core/constants/app_constance.dart';
import 'package:baby_care/core/services/session_storage_service.dart';
import 'package:baby_care/core/utils/app_color.dart';
import 'package:baby_care/core/widgets/custom_webview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShopAppPage extends StatefulWidget {
  const ShopAppPage({super.key});

  @override
  State<StatefulWidget> createState() => _ShopAppPageState();
}

class _ShopAppPageState extends State<ShopAppPage> {
  final String shopUrl = AppConstants.feBaseUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Shopping',
          style: TextStyle(
            color: AppColors.textColor,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Icon(CupertinoIcons.bell),
            ),
          ),
        ],
      ),
      body: CustomWebView(url: shopUrl),
    );
  }
}
