import 'package:flutter/material.dart';

class CoreAnimatedContainer extends StatelessWidget {
  final double? width;
  final double? height;
  final BoxDecoration? decoration;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final AlignmentGeometry? alignment;
  final Widget? child;
  final Duration duration;
  final Curve curve;

  const CoreAnimatedContainer({
    super.key,
    this.width,
    this.height,
    this.decoration,
    this.padding,
    this.margin,
    this.alignment,
    this.child,
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.easeInOut,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: width,
      height: height,
      decoration: decoration,
      padding: padding,
      margin: margin,
      alignment: alignment,
      duration: duration,
      curve: curve,
      child: child,
    );
  }
}