import 'package:flutter/material.dart';

class CoreAnimatedPadding extends StatelessWidget {
  final EdgeInsets padding;
  final Widget child;
  final Duration duration;
  final Curve curve;

  const CoreAnimatedPadding({
    super.key,
    required this.padding,
    required this.child,
    this.duration = const Duration(milliseconds: 250),
    this.curve = Curves.easeInOut,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      padding: padding,
      duration: duration,
      curve: curve,
      child: child,
    );
  }
}
