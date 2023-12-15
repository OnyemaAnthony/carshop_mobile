import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final VoidCallback? onPress;
  final String text;
  final Widget? logo;

  SubmitButton({Key? key, this.onPress, this.logo, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        // color: Colors.black,
        gradient: LinearGradient(
          colors: [
            Colors.purple.shade400,
            Color(0xFFED6EA0),
            Color(0xFFEC8EDA)
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      constraints: const BoxConstraints(
        minWidth: 88.0,
        minHeight: 36.0,
      ),
      alignment: Alignment.center,
      child: ElevatedButton(
        onPressed: onPress,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: logo,
          ),
          Text(text, style: Theme.of(context).textTheme.titleMedium),
        ]),
      ),
    );
  }
}
