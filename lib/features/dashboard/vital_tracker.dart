import 'package:baby_care/core/constants/app_constance.dart';
import 'package:baby_care/core/widgets/custom_webview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VitalTrackerPage extends StatefulWidget {
  const VitalTrackerPage({super.key});

  @override
  State<VitalTrackerPage> createState() => _AnalyticPageState();
}

class _AnalyticPageState extends State<VitalTrackerPage> {
  final String vitalTrackerPageUrl = '${AppConstants.feBaseUrl}/analytics';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
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
      body: CustomWebView(url: vitalTrackerPageUrl),
    );
  }
}