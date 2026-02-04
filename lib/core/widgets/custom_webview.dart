import 'package:baby_care/core/services/session_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class CustomWebView extends StatefulWidget{
  final String url;
  const CustomWebView({super.key, required this.url});
  @override
  State<CustomWebView> createState() => _CustomWebViewState();
}

class _CustomWebViewState extends State<CustomWebView>{
    late InAppWebViewController webViewController;
  final String? sessionId = SessionStorageService.instance.getSession();
  bool isCookiesSet = false;


  @override
  void initState() {
    super.initState();
    _setSessionCookie();
  }

  Future<void> _setSessionCookie() async {
    if (sessionId == null) {
      return;
    }
    await CookieManager.instance().setCookie(
      url: WebUri(widget.url),
      name: 'session_id',
      value: sessionId!,
      path: '/',
    );
    setState(() {
      isCookiesSet = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (await webViewController.canGoBack()) {
          webViewController.goBack();
          return false;
        }
        return true;
      },
      child: Scaffold(
        body: sessionId != null
            ? (isCookiesSet
            ? InAppWebView(
          initialUrlRequest: URLRequest(url: WebUri(widget.url)),
          onWebViewCreated: (controller) async {
            webViewController = controller;
          },
        )
            : const Center(child: CircularProgressIndicator()))
            : Center(child: Text('No session found. Please login first.')),
      ),
    );
  }
}