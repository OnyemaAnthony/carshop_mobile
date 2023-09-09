import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class ScreenSize {
  static double getStatusBarHeight(BuildContext context) {
    return MediaQuery.of(context).padding.top;
  }

  static double getResponsiveText(num font) {
    return font.sp;
  }

  static double getScreenHeight(num value) {
    return value.sh;
  }

  static double getScreenWidth(num value) {
    return value.sw;
  }

  static double getScreenHeightScale(num value) {
    return value.h;
  }

  static double getScreenWidthScale(num value) {
    return value.w;
  }
}
