import 'package:flutter/material.dart';
import 'package:untitled/utils/constants/sizes.dart';

import '../../../../utils/constants/colors.dart';


class TRoundedContainer extends StatelessWidget {
  const TRoundedContainer({
    super.key,
    this.child,
    this.width,
    this.height,
    this.margin,
    this.padding,
    this.showBorder = false,
    this.radius = TSizes.cardRadiusLg,
    this.backgroundColor = TColors.primary,
    this.borderColor = TColors.borderPrimary,

  });

  final double? width;
  final double? height;
  final double? radius;
  final Widget? child;
  final bool showBorder;
  final Color borderColor;
  final Color backgroundColor;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(radius!),
        border: showBorder ? Border.all(color: borderColor) : null,
      ),
      child: child,
    );
  }
}