import 'package:carshop_mobile/utilities/colors.dart';
import 'package:carshop_mobile/utilities/extensions.dart';
import 'package:carshop_mobile/widgets/shared_widgets/build_icon.dart';
import 'package:carshop_mobile/widgets/shared_widgets/build_text.dart';
import 'package:flutter/material.dart';

class SocialLoginButton extends StatelessWidget {
  final Function() onPressed;
  final String text;
  final IconData? icon;
  final Color? iconColor;
  final String? image;
  const SocialLoginButton(
      {super.key,
      required this.onPressed,
      required this.text,
      this.icon,
      this.iconColor,
      this.image});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: 0.0.symmetricPadding(vertical: 3.0),
      child: ElevatedButton(
        style: ButtonStyle(
          minimumSize:
              MaterialStateProperty.all(const Size(double.infinity, 40)),
          padding: MaterialStateProperty.all(
            20.0.symmetricPadding(),
          ),
          textStyle: MaterialStateProperty.all(
            TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14.scaledPixels(),
            ),
          ),
          shape: MaterialStateProperty.all(
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
          ),
          elevation: MaterialStateProperty.all(0),
          backgroundColor: MaterialStateProperty.all(AppColors.primaryColor),
          foregroundColor: MaterialStateProperty.all(AppColors.thirdLightColor),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (image != null) ...[
              Image(
                image: AssetImage(image!),
                height: 15.scaledPixels(),
              ),
              0.sizedBox(width: 7),
            ],
            if (icon != null) ...[
              BuildIcon(
                icon: icon!,
                color: iconColor,
              ),
              0.sizedBox(width: 5),
            ],
            BuildText(text: text),
          ],
        ),
      ),
    );
  }
}
