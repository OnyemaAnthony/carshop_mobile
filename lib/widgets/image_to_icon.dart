import 'package:flutter/material.dart';

class ImageToIcon extends StatelessWidget {
  final String? imagePath;
  final double? width;
  final double? height;
  final Color? color;
  final Function()? onTap;

  const ImageToIcon(
      {super.key,
      this.color,
      this.height,
      required this.imagePath,
      this.width,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Image.asset(
        imagePath!,
        width: width,
        height: height,
        color: color,
      ),
    );
  }
}
