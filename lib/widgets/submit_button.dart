import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final VoidCallback? onPress;
   SubmitButton({Key? key,this.onPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
          backgroundColor: Theme.of(context).primaryColor),

        onPressed: onPress, child: const Text('Submit',style: TextStyle(color: Colors.white),));
  }
}
