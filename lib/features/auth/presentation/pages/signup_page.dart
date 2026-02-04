import 'package:baby_care/core/constants/app_constance.dart';
import 'package:baby_care/core/utils/app_color.dart';
import 'package:baby_care/core/widgets/custom_button.dart';
import 'package:baby_care/core/widgets/page_layout_widget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _loading = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  Future<void> _showMessage(String message) async {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email);
  }

  Future<void> _requestEmailSignup() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      await _showMessage('Please fill all fields');
      return;
    }
    if (!_isValidEmail(email)) {
      await _showMessage('Please enter a valid email');
      return;
    }
    if (password != confirmPassword) {
      await _showMessage('Passwords do not match');
      return;
    }

    setState(() {
      _loading = true;
    });

    try {
      final dio = Dio(
        BaseOptions(
          baseUrl: AppConstants.apiBaseUrl,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': AppConstants.emailSignupBasicAuth,
          },
        ),
      );

      final response = await dio.post<Map<String, dynamic>>(
        AppConstants.emailSignupRequestPath,
        data: {
          "email": email,
          "password": password,
        },
      );

      final data = response.data ?? <String, dynamic>{};
      if (data['ok'] == true) {
        final expiresAtRaw = data['expires_at'];
        final expiresAt = expiresAtRaw is String ? DateTime.tryParse(expiresAtRaw) : null;
        final expiresText = expiresAt == null ? '' : ' (expires ${expiresAt.toLocal()})';
        await _showMessage('Verification link sent to your email$expiresText');
      } else {
        await _showMessage(data['message']?.toString() ?? 'Signup failed');
      }
    } on DioException catch (e) {
      final serverMessage = (e.response?.data is Map<String, dynamic>)
          ? (e.response?.data['message']?.toString())
          : null;
      await _showMessage(serverMessage ?? 'Signup error: ${e.message ?? e.toString()}');
    } catch (e) {
      await _showMessage('Signup error: ${e.toString()}');
    } finally {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        title: const Text('Sign up'),
      ),
      body: SafeArea(
        child: PageLayoutWidget(
          bottomChild: Container(
            decoration: const BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadiusDirectional.vertical(top: Radius.circular(32)),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 12,
                children: [
                  CustomButton(
                    text: _loading ? 'Sending link...' : 'Send verification link',
                    onPressed: _loading ? () {} : _requestEmailSignup,
                    bgColor: Colors.white,
                    textColor: AppColors.primaryColor,
                  ),
                  TextButton(
                    onPressed: _loading ? null : () => Navigator.pop(context),
                    child: const Text('Back to sign in', style: TextStyle(color: Colors.white)),
                  ),
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
                  const Text(
                    'Create your account',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 28),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      hintText: 'your@example.com',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                  TextField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      suffixIcon: IconButton(
                        icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility),
                        onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                      ),
                    ),
                  ),
                  TextField(
                    controller: _confirmPasswordController,
                    obscureText: _obscureConfirmPassword,
                    decoration: InputDecoration(
                      labelText: 'Confirm password',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
                        ),
                        onPressed: () => setState(
                          () => _obscureConfirmPassword = !_obscureConfirmPassword,
                        ),
                      ),
                    ),
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

