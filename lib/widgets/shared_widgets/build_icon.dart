import 'package:carshop_mobile/utilities/extensions.dart';
import 'package:flutter/material.dart';

import '../../utilities/colors.dart';

class BuildIcon extends StatelessWidget {
  final IconData icon;
  final Color? color;
  final double? size;
  const BuildIcon({super.key, required this.icon, this.color, this.size});

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      size: (size ?? 20).scaledPixels(),
      color: color ?? AppColors.primaryColor,
    );
  }
}
