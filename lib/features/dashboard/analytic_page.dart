import 'package:baby_care/core/constants/app_constance.dart';
import 'package:baby_care/core/widgets/custom_webview.dart';
import 'package:flutter/material.dart';

class AnalyticPage extends StatefulWidget {
  const AnalyticPage({super.key});

  @override
  State<AnalyticPage> createState() => _AnalyticPageState();
}

class _AnalyticPageState extends State<AnalyticPage> {
  final String analyticPageUrl = '${AppConstants.feBaseUrl}/analytics/analytics-cycle';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: CustomWebView(url: analyticPageUrl)
    );
  }
}
