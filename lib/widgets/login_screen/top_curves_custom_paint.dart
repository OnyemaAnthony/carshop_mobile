import 'package:carshop_mobile/utilities/extensions.dart';
import 'package:flutter/material.dart';

import 'top_curve_custom_paint/top_fsm_custom_painter.dart';

class TopCurveCustomPaint extends StatelessWidget {
  const TopCurveCustomPaint({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: .35.screenHeight(),
        width: 1.0.screenWidth(),
        child: CustomPaint(
          painter: TopFSMCustomPainter(),
        ));
  }
}
