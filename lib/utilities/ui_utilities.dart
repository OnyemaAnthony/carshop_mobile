import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
class UiUtilities{

  static void showToast({required String message, required Toast toast}){
    Fluttertoast.showToast(
        msg: message,
        toastLength: toast,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.black,
        fontSize: 16.0
    );

  }


  void push(BuildContext context,Widget screen){
    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>screen));
  }

  void pushReplacement(BuildContext context,Widget screen){
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>screen));
  }
}