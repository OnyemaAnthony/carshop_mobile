import 'package:flutter/cupertino.dart';

class DaynoLoadingIndicator extends StatelessWidget {
  final double? width;
  final double? height;

  const DaynoLoadingIndicator({
    super.key,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Image.asset(
      'assets/images/loader.gif',
      width: width,
      height: width,
    ));
  }
}
