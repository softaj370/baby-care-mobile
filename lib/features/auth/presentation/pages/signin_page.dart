import 'package:baby_care/core/constants/app_constance.dart';
import 'package:baby_care/core/services/session_storage_service.dart';
import 'package:baby_care/core/utils/app_color.dart';
import 'package:baby_care/core/widgets/custom_button.dart';
import 'package:baby_care/core/widgets/navigation_layout.dart';
import 'package:baby_care/core/widgets/page_layout_widget.dart';
import 'package:baby_care/features/auth/presentation/pages/logged_in_page.dart';
import 'package:baby_care/features/auth/presentation/pages/signup_page.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final String signInApi =
      '${AppConstants.apiBaseUrl}/web/session/authenticate';
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _loading = false;
  bool _obscure = true;
  String? babyExpectDate;

  Future<void> _showMessage(String message) async {
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _signIn() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      await _showMessage('Please enter email and password');
      return;
    }

    setState(() {
      _loading = true;
    });

    final dio = Dio();
    final cookieJar = CookieJar();
    dio.interceptors.add(CookieManager(cookieJar));

    try {
      final response = await dio.post(
        signInApi,
        data: {
          "jsonrpc": "2.0",
          "method": "call",
          "params": {"db": "odoo", "login": email, "password": password},
        },
      );
      String? date;
      if (response.data.containsKey('result') &&
          response.data['result'] != null) {
        date = response.data['result']['partner']["expected_baby"];
        final uri = Uri.parse(signInApi);
        final cookies = await cookieJar.loadForRequest(uri);
        String? sessionValue;
        for (final c in cookies) {
          final name = c.name.toLowerCase();
          if (name.contains('session_id')) {
            sessionValue = c.value;
            break;
          }
        }

        if (sessionValue != null) {
          await SessionStorageService.instance.saveSession(sessionValue);
        }

        babyExpectDate = date is String ? date : null;

        // navigate to logged in page
        if (!mounted) return;
        print(SessionStorageService.instance.getSession());
        if (babyExpectDate == null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const LoggedInPage()),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const NavigationLayout()),
          );
        }
      } else {
        String msg = 'Login failed';
        await _showMessage(msg);
      }
    } catch (e) {
      await _showMessage('Login error: ${e.toString()}');
      print(e.toString());
    } finally {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: PageLayoutWidget(
          bottomChild: Container(
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadiusDirectional.vertical(
                top: Radius.circular(32),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 12,
                children: [
                  CustomButton(
                    text: _loading ? 'Signing in...' : 'Sign in',
                    onPressed: _loading ? () {} : _signIn,
                    bgColor: Colors.white,
                    textColor: AppColors.primaryColor,
                  ),
                  CustomButton(
                    text: 'Sign up',
                    onPressed: _loading
                        ? () {}
                        : () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const SignUpPage(),
                              ),
                            );
                          },
                    bgColor: Colors.white,
                    textColor: AppColors.primaryColor,
                  ),
                  SizedBox(height: 8),
                ],
              ),
            ),
          ),
          children: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 16,
                children: [
                  Text(
                    'Sign in to your account',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 28),
                  ),
                  SizedBox(height: 8),
                  TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      hintText: 'your@example.com',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  TextField(
                    controller: _passwordController,
                    obscureText: _obscure,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscure ? Icons.visibility_off : Icons.visibility,
                        ),
                        onPressed: () => setState(() => _obscure = !_obscure),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          // forgot flow placeholder
                          _showMessage('Forgot password flow not implemented');
                        },
                        child: Text(
                          'Forgot password?',
                          style: TextStyle(color: AppColors.primaryColor),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
