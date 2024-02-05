import 'package:flutter/material.dart';

class CircularBox extends StatefulWidget {
  const CircularBox({super.key});

  @override
  State<CircularBox> createState() => _CircularBoxState();
}

class _CircularBoxState extends State<CircularBox> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isChecked = !isChecked;
        });
      },
      child: Container(
        width: 30.0,
        height: 30.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.black, width: 2.0),
          color: isChecked ? Colors.green : Colors.transparent,
        ),
        child: isChecked
            ? const Icon(
                Icons.check,
                color: Colors.white,
                size: 20.0,
              )
            : null,
      ),
    );
  }
}
