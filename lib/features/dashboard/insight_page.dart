import 'package:baby_care/core/constants/app_constance.dart';
import 'package:baby_care/core/utils/app_color.dart';
import 'package:baby_care/core/widgets/custom_webview.dart';
import 'package:baby_care/core/widgets/most_popular_card.dart';
import 'package:baby_care/core/widgets/reproductive_card.dart';
import 'package:baby_care/core/widgets/top_pick_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class InsightPage extends StatefulWidget {
  const InsightPage({super.key});

  @override
  State<InsightPage> createState() => _InsightPageState();
}

class _InsightPageState extends State<InsightPage> {
  final String insightPageUrl = '${AppConstants.feBaseUrl}/article';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomWebView(url: insightPageUrl)
    );
  }
}
