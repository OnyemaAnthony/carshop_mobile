import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../widgets/shared_widgets/build_text.dart';
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

  static void navBarReplacement(
      BuildContext context, Widget screen, bool withNavBar) {
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

  static Widget showMainLoader() {
    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 26,
            ),
            Image.asset(
              "assets/images/loader.gif",
              height: 300,
              width: 300,
            ),
          ],
        ),
      ),
    );
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
