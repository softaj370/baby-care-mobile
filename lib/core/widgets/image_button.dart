import 'package:flutter/material.dart';

class ImageButton extends StatelessWidget {
  final String imagePath;
  final double width;
  final double height;
  final VoidCallback onTap;

  const ImageButton({
    super.key,
    required this.imagePath,
    required this.onTap,
    this.width = 80,
    this.height = 80,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
        padding: EdgeInsets.all(24),
        height: height,
        width: width,
        child: Image.asset(imagePath),
      ),
    );
  }
}
