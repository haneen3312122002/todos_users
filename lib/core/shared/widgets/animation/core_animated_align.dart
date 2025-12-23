import 'package:flutter/material.dart';

class CoreAnimatedAlign extends StatelessWidget {
  final Alignment alignment;
  final Widget child;
  final Duration duration;
  final Curve curve;

  const CoreAnimatedAlign({
    super.key,
    required this.alignment,
    required this.child,
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.easeInOut,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedAlign(
      alignment: alignment,
      duration: duration,
      curve: curve,
      child: child,
    );
  }
}