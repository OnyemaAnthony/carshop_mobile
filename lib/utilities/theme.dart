import 'package:carshop_mobile/utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CarShopTheme {
  static ThemeData getLightTheme(BuildContext context) {
    return ThemeData(
      useMaterial3: true,
      pageTransitionsTheme: const PageTransitionsTheme(),
      primarySwatch: MaterialColor(AppColors.primaryColorLight.value, const {
        50: Color(0xfff2f2f2),
        100: Color(0xffe6e6e6),
        200: Color(0xffcccccc),
        300: Color(0xffb3b3b3),
        400: Color(0xff999999),
        500: Color(0xff808080),
        600: Color(0xff666666),
        700: Color(0xff4d4d4d),
        800: Color(0xff333333),
        900: Color(0xff191919),
      }),
      brightness: Brightness.light,
      primaryColor: AppColors.primaryColorLight,
      primaryColorLight: Colors.white,
      primaryColorDark: Colors.white,
      bottomAppBarTheme: const BottomAppBarTheme(color: Colors.white),
      dividerColor: Colors.white,
      highlightColor: Colors.white,
      appBarTheme: const AppBarTheme(
        elevation: 0,
        color: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        foregroundColor: Colors.black,
      ),
      scaffoldBackgroundColor: AppColors.scaffoldColorLight,
      canvasColor: Colors.white,
      cardTheme: const CardTheme(color: Colors.white),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: AppColors.primaryColorLight,
      ),
      cardColor: Colors.white,
      primaryTextTheme: const TextTheme(
          titleLarge: TextStyle(
        color: Colors.black,
      )),
      textTheme: TextTheme(
        displayLarge: GoogleFonts.inter(
          fontSize: 26.0,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        titleLarge: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w900,
        ),
        titleMedium:
            GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w900),
        bodySmall: GoogleFonts.inter(fontSize: 12),
        titleSmall: GoogleFonts.inter(
          color: const Color(
            0xff808080,
          ),
          fontSize: 14,
        ),
        bodyLarge: GoogleFonts.inter(
            color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
        bodyMedium: GoogleFonts.inter(fontSize: 14.0, color: Colors.black),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          backgroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.all(5),
          textStyle: const TextStyle(
            color: AppColors.primaryColorLight,
          ),
        ),
      ),
    );
  }

  static ThemeData getDarkTheme(BuildContext context) {
    return ThemeData(
      useMaterial3: true,
      primarySwatch: MaterialColor(AppColors.primaryColorLight.value, const {
        50: Color(0xfff2f2f2),
        100: Color(0xffe6e6e6),
        200: Color(0xffcccccc),
        300: Color(0xffb3b3b3),
        400: Color(0xff999999),
        500: Color(0xff808080),
        600: Color(0xff666666),
        700: Color(0xff4d4d4d),
        800: Color(0xff333333),
        900: Color(0xff191919)
      }),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.white,
      ),
      brightness: Brightness.dark,
      primaryColor: AppColors.primaryColorDark,
      canvasColor: Colors.black,
      scaffoldBackgroundColor: AppColors.scaffoldColorDark,
      dividerColor: Colors.grey,
      unselectedWidgetColor: Colors.grey,
      textTheme: TextTheme(
        displayLarge: const TextStyle(
          fontSize: 26.0,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        titleLarge: GoogleFonts.inter(
            fontSize: 30, fontWeight: FontWeight.w900, color: Colors.white),
        titleSmall: GoogleFonts.inter(
          color: const Color(
            0xff808080,
          ),
          fontSize: 12,
        ),
        bodyMedium: const TextStyle(fontSize: 14.0, color: Colors.black),
        displayMedium: GoogleFonts.inter(
            fontWeight: FontWeight.w400, fontSize: 14, color: Colors.black),
      ),
      secondaryHeaderColor: Colors.black,
      hintColor: Colors.grey,
      dialogTheme: const DialogTheme(
          shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Color(0xff000000),
          width: 0,
          style: BorderStyle.none,
        ),
        borderRadius: BorderRadius.all(Radius.circular(0.0)),
      )),
    );
  }
}
