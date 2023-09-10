import 'package:carshop_mobile/utilities/extensions.dart';
import 'package:carshop_mobile/widgets/login_screen/bottom_curve_custom_paint/bottom_fsm_custom_painter.dart';
import 'package:flutter/material.dart';

class BottomCurveCustomPaint extends StatelessWidget {
  const BottomCurveCustomPaint({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: .15.screenHeight(),
      width: 1.screenWidth(),
      child: CustomPaint(
        painter: BottomFSMCustomPainter(),
      ),
    );
  }
}
