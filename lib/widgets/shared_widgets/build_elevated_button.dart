import 'package:carshop_mobile/utilities/colors.dart';
import 'package:carshop_mobile/widgets/shared_widgets/build_text.dart';
import 'package:flutter/material.dart';

class BuildElevatedButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  final double? fontSize;
  final FontWeight? fontWeight;
  final bool? empty;
  final Color? fontColor;

  const BuildElevatedButton(
      {super.key,
      required this.text,
      required this.onPressed,
      this.fontSize,
      this.fontWeight,
      this.empty,
      this.fontColor});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(0),
        backgroundColor: MaterialStateProperty.all(empty == null
            ? AppColors.primaryColorLight
            : Theme.of(context).scaffoldBackgroundColor),
        padding: MaterialStateProperty.all(EdgeInsets.zero),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            side: BorderSide(
              width: 2,
              color: AppColors.primaryColorLight.withOpacity(.8),
            ),
          ),
        ),
      ),
      onPressed: onPressed,
      child: BuildText(
        text: text,
        fontSize: fontSize ?? 16,
        fontWeight: fontWeight ?? FontWeight.normal,
        color: empty == null ? Colors.white : Colors.black,
      ),
    );
  }
}
