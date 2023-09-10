import 'package:carshop_mobile/utilities/colors.dart';
import 'package:carshop_mobile/utilities/extensions.dart';
import 'package:flutter/material.dart';

class BuildText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  const BuildText(
      {super.key,
      required this.text,
      this.fontSize,
      this.fontWeight,
      this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: fontWeight ?? FontWeight.normal,
        color: color ?? AppColors.thirdLightColor,
        fontSize: (fontSize ?? 14).scaledPixels(),
      ),
    );
  }
}
