import 'package:flutter/material.dart';

class IconTile extends StatelessWidget {
  final String iconPath;

  const IconTile({super.key, required this.iconPath});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(.2), shape: BoxShape.circle),
      padding: const EdgeInsets.all(10),
      child: Image.asset(
        iconPath,
        width: 40,
        height: 40,
      ),
    );
  }
}
