import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:shimmer/shimmer.dart';

import '../widgets/shared_widgets/build_text.dart';
import '../widgets/shimmer_loader.dart';
import 'colors.dart';

class UiUtilities {
  static void showToast({required String message, required Toast toast}) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: toast,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.black,
        fontSize: 16.0);
  }

  static void showSnackBar(
      {required String txt, required BuildContext context}) {
    SnackBar snackBar = SnackBar(
      content: BuildText(
        text: txt,
        fontSize: 13.5,
        color: AppColors.thirdLightColor,
      ),
      backgroundColor: Theme.of(context).primaryColor,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void push(BuildContext context, Widget screen) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => screen));
  }

  static void pop(BuildContext context) {
    Navigator.of(context).pop();
  }

  static void pushReplacement(BuildContext context, Widget screen) {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => screen));
  }

  static void pushNavBar(BuildContext context, Widget screen, bool withNavBar) {
    PersistentNavBarNavigator.pushNewScreen(context,
        screen: screen, withNavBar: withNavBar);
  }

  static showLoader() {
    return const Center(
      child: CircularProgressIndicator(
        color: AppColors.thirdLightColor,
      ),
    );
  }

  static showShimmerLoader(BuildContext context) {
    return SizedBox(
      width: 200.0,
      height: 100.0,
      child: Shimmer.fromColors(
        baseColor: Colors.red,
        highlightColor: Colors.yellow,
        child: const Text(
          'Shimmer',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 40.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  static Widget showMainLoader() {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }

  static accountShimmer() {
    return SingleChildScrollView(
      child: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Container(
                height: 200,
                margin: const EdgeInsets.all(8),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: const CarShopShimmer(
                  cornerRadius: 8,
                  height: 160,
                  width: double.infinity,
                  highlightColor: Colors.grey,
                ),
              ),
              Container(
                height: 700,
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: const CarShopShimmer(
                  cornerRadius: 8,
                  height: 300,
                  width: double.infinity,
                  highlightColor: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static translate(BuildContext context, String text) {
    return context.tr(text);
  }

  static Widget showErrorMessage(String message) {
    return Center(
      child: Text(
        message,
        style: const TextStyle(color: Colors.black),
      ),
    );
  }
}
