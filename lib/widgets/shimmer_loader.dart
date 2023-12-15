import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CarShopShimmer extends StatelessWidget {
  final double? height;
  final double? width;
  final double? horizontalMargin;
  final double? verticalMargin;
  final double? cornerRadius;
  final Color? highlightColor;

  const CarShopShimmer({
    Key? key,
    this.height,
    this.width,
    this.horizontalMargin = 0,
    this.verticalMargin = 0,
    this.cornerRadius = 0.0,
    this.highlightColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.white,
      highlightColor: highlightColor ?? Colors.grey[300]!,
      child: Container(
        height: height,
        width: width,
        margin: EdgeInsets.symmetric(
            horizontal: horizontalMargin!, vertical: verticalMargin!),
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(cornerRadius!),
        ),
      ),
    );
  }
}
