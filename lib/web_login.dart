import 'package:baby_care/core/constants/app_constance.dart';
import 'package:baby_care/core/services/session_storage_service.dart';
import 'package:baby_care/screens/date_picker_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class OdooLoginPage extends StatefulWidget {
  const OdooLoginPage({super.key});

  @override
  State<StatefulWidget> createState() => _OdooLoginPageState();
}

class _OdooLoginPageState extends State<OdooLoginPage> {
  late InAppWebViewController webViewController;
  final String odooLoginUrl = '${AppConstants.apiBaseUrl}/web/login';

  Future<void> _onLoginComplete(String? title) async{
    CookieManager cookieManager = CookieManager.instance();
    List<Cookie> cookies = await cookieManager.getCookies(
      url: WebUri(odooLoginUrl),
    );

    print(cookies);

    for (var cookie in cookies) {
      if (title?.toLowerCase() == "discuss" &&
          cookie.name == 'session_id') {
        SessionStorageService.instance.saveSession(cookie.value);
      }
    }

    if (SessionStorageService.instance.getSession() != null && mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => DatePickerPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login with Odoo')),
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: WebUri(odooLoginUrl)),
        onWebViewCreated: (controller) async {
          webViewController = controller;
        },
        onProgressChanged: (controller, value) {
          print('${value} here');
        },
        onTitleChanged: (webViewController, title) async {
          print(title);
          _onLoginComplete(title);
        },
      ),
    );
  }
}
