import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final VoidCallback? onPress;
  final String text;

  const SubmitButton({Key? key, this.onPress, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          text,
        ),
      ]),
    );
  }
}
