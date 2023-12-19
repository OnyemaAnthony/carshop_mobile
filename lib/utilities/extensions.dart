import 'package:carshop_mobile/utilities/screen_size.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

extension SizedBoxExtentions on num {
  SizedBox sizedBox({num? width}) => SizedBox(
        height: toDouble(),
        width: width?.toDouble(),
      );
}

extension ScreenSizeExtension on num {
  double scaledPixels() => ScreenSize.getResponsiveText(this);

  double screenHeight() => ScreenSize.getScreenHeight(this);

  double screenWidth() => ScreenSize.getScreenWidth(this);

  double screenHeightScale() => ScreenSize.getScreenHeightScale(this);

  double screenWidthScale() => ScreenSize.getScreenWidthScale(this);
}

extension Translate on String {
  String trans(BuildContext context) {
    return context.tr(this);
  }
}

extension PaddingExtension on double {
  EdgeInsetsGeometry symmetricPadding({double? vertical}) =>
      EdgeInsets.symmetric(
        vertical: (vertical ?? 0).toDouble().screenHeightScale(),
        horizontal: screenWidthScale(),
      );
}
