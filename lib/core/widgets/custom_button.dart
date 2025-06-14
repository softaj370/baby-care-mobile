import 'package:baby_care/core/utils/app_color.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final double width;
  final String text;
  final VoidCallback onPressed;
  final Color textColor;
  final Color bgColor;
  final bool isDisabled;

  const CustomButton({
    super.key,
    this.width = double.maxFinite,
    required this.text,
    required this.onPressed,
    this.textColor = Colors.white,
    this.bgColor = AppColors.primaryColor,
    this.isDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        onPressed: isDisabled ? () {} : onPressed,
        style: ButtonStyle(
          padding: WidgetStatePropertyAll(
            EdgeInsets.symmetric(vertical: 8, horizontal: 32),
          ),
          elevation: WidgetStatePropertyAll(1),
          backgroundColor: WidgetStatePropertyAll(
            isDisabled ? bgColor.withAlpha(150) : bgColor,
          ),
        ),
        child: Text(text, style: TextStyle(color: textColor, fontSize: 14)),
      ),
    );
  }
}
