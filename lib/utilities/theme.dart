import 'package:carshop_mobile/utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CarShopTheme {
  static ThemeData getLightTheme(BuildContext context) {
    final lightTheme = ThemeData.light().copyWith(
      useMaterial3: true,
      pageTransitionsTheme: const PageTransitionsTheme(),
      primaryColor: AppColors.primaryColorLight,
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: AppColors.primaryColorLight,
      ),
      textTheme: GoogleFonts.interTextTheme(ThemeData.light().textTheme),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          elevation: 0,
          padding: const EdgeInsets.all(5),
          textStyle: const TextStyle(
            color: AppColors.primaryColorLight,
          ),
        ),
      ),
    );
    return lightTheme;
  }

  static ThemeData getDarkTheme(BuildContext context) {
    return ThemeData.dark().copyWith(
      useMaterial3: true,
      primaryColor: AppColors.primaryColorDark,
      textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
      dialogTheme: const DialogTheme(
          shape: RoundedRectangleBorder(
        side: BorderSide(
          width: 0,
          style: BorderStyle.none,
        ),
        borderRadius: BorderRadius.all(Radius.circular(0.0)),
      )),
    );
  }
}
