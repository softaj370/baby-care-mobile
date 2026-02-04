import 'package:baby_care/core/constants/app_constance.dart';
import 'package:baby_care/core/services/session_storage_service.dart';
import 'package:baby_care/core/utils/app_color.dart';
import 'package:baby_care/core/widgets/custom_button.dart';
import 'package:baby_care/core/widgets/navigation_layout.dart';
import 'package:baby_care/core/widgets/page_layout_widget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateConfirmationPage extends StatefulWidget {
  final String title;
  final DateTime date;

  const DateConfirmationPage({
    super.key,
    required this.title,
    required this.date,
  });

  @override
  State<DateConfirmationPage> createState() => _DateConfirmationPageState();
}

class _DateConfirmationPageState extends State<DateConfirmationPage> {
  bool _saving = false;

  Future<void> _showMessage(String message) async {
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _confirmDate() async {
    final sessionId = SessionStorageService.instance.getSession();
    if (sessionId == null || sessionId.isEmpty) {
      await _showMessage('Session expired. Please sign in again.');
      return;
    }

    setState(() {
      _saving = true;
    });

    try {
      final dio = Dio(BaseOptions(baseUrl: AppConstants.apiBaseUrl));
      final dateString = DateFormat('yyyy-MM-dd').format(widget.date);

      final response = await dio.post(
        AppConstants.callKw,
        data: {
          "jsonrpc": "2.0",
          "method": "call",
          "params": {
            "model": "baby.util.widget",
            "method": "update_expected_baby",
            "args": [dateString],
            "kwargs": {},
          },
          "id": 1,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': AppConstants.emailSignupBasicAuth,
            "Cookie": "session_id=$sessionId",
          },
        ),
      );

      final isOk = response.statusCode == 200 &&
          response.data is Map &&
          (response.data as Map).containsKey('result');
      if (!isOk) {
        await _showMessage('Failed to save date. Please try again.');
        return;
      }

      if (!mounted) return;
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (builder) => NavigationLayout(),
        ),
        (Route<dynamic> route) => false,
      );
    } on DioException catch (e) {
      await _showMessage('Failed to save date: ${e.message ?? 'Network error'}');
    } catch (e) {
      await _showMessage('Failed to save date: ${e.toString()}');
    } finally {
      if (mounted) {
        setState(() {
          _saving = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageLayoutWidget(
        bottomChild: Container(
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadiusDirectional.vertical(
              top: Radius.circular(32),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 64),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 16,
              children: [
                CustomButton(
                  text: _saving ? "Saving..." : "Yes, that's right",
                  onPressed: _saving ? () {} : _confirmDate,
                  bgColor: Colors.white,
                  textColor: AppColors.primaryColor,
                ),
                CustomButton(
                  text: "No, Update date",
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  bgColor: Colors.white,
                  textColor: AppColors.primaryColor,
                ),
                CustomButton(
                  text: "No",
                  onPressed: () {},
                  bgColor: Colors.white,
                  textColor: AppColors.primaryColor,
                ),
              ],
            ),
          ),
        ),
        children: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                  ),
                  SizedBox(
                    width: 300,
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              "assets/images/bubble-circle.png",
                            ),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              DateFormat.MMMM().format(widget.date),
                              style: TextStyle(
                                height: 0,
                                color: AppColors.textColor,
                                fontSize: 48,
                                fontWeight: FontWeight.w500,
                                shadows: [
                                  Shadow(
                                    offset: Offset(0, 4),
                                    blurRadius: 4,
                                    color: Colors.black.withAlpha(25),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              widget.date.day.toString(),
                              style: TextStyle(
                                height: 0,
                                color: AppColors.textColor,
                                fontSize: 74,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
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
