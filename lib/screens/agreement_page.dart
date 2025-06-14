import 'package:baby_care/core/utils/app_color.dart';
import 'package:baby_care/core/widgets/custom_button.dart';
import 'package:baby_care/core/widgets/page_layout_widget.dart';
import 'package:baby_care/features/auth/login_page.dart';
import 'package:flutter/material.dart';

class AgreementPage extends StatefulWidget {
  const AgreementPage({super.key});

  @override
  State<StatefulWidget> createState() => _AgreementPageState();
}

class _AgreementPageState extends State<AgreementPage> {
  bool isCheckedFirst = false;
  bool isCheckedSecond = false;
  String agreementDetails =
      "Where you do not grant consent we will not be able to use your personal data for marketing purposes (so for example, we may not be able to let you know about open days or special offers). We will still be able to use your personal data for: yours or our legitimate interests in connection with the provision of health care services to you.";
  String agreementNoteMessage =
      "*You can withdraw or change your consent at any time by contacting Ayata Inc. via email.";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: PageLayoutWidget(
          bottomChild: Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            decoration: BoxDecoration(color: Colors.white),
            child: CustomButton(
              text: "Continue",
              isDisabled: !(isCheckedFirst && isCheckedSecond),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            ),
          ),
          children: Container(
            decoration: BoxDecoration(color: Colors.white),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 64, horizontal: 12),
              child: Column(
                spacing: 12,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Welcome",
                    style: TextStyle(fontSize: 48, fontWeight: FontWeight.w600),
                  ),

                  CheckboxListTile(
                    activeColor: AppColors.primaryColor,
                    checkboxShape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(20),
                    ),
                    value: isCheckedFirst,
                    side: BorderSide(width: 2, color: AppColors.textColor),
                    onChanged: (value) {
                      setState(() {
                        isCheckedFirst = value!;
                      });
                    },
                    contentPadding: EdgeInsets.zero,
                    controlAffinity: ListTileControlAffinity.leading,
                    checkColor: Colors.transparent,
                    dense: true,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "I agree to Privacy Policy and Terms of Use.",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  CheckboxListTile(
                    activeColor: AppColors.primaryColor,
                    checkboxShape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(20),
                    ),
                    value: isCheckedSecond,
                    side: BorderSide(width: 2, color: AppColors.textColor),
                    onChanged: (value) {
                      setState(() {
                        isCheckedSecond = value!;
                      });
                    },
                    contentPadding: EdgeInsets.zero,
                    controlAffinity: ListTileControlAffinity.leading,
                    checkColor: Colors.transparent,
                    dense: true,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "I agree to storing and processing of my personal data ....... to send me product or service offerings. ",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Text(
                      agreementDetails,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        color: AppColors.grayTextColor,
                      ),
                    ),
                  ),
                  SizedBox(height: 32),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Text(
                      agreementNoteMessage,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppColors.grayTextColor,
                        fontStyle: FontStyle.italic,
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
