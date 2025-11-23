import 'package:flutter/material.dart';

class CoreAnimatedOpacity extends StatelessWidget {
  final bool visible;
  final Widget child;
  final Duration duration;
  final Curve curve;

  const CoreAnimatedOpacity({
    super.key,
    required this.visible,
    required this.child,
    this.duration = const Duration(milliseconds: 250),
    this.curve = Curves.easeInOut,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: visible ? 1.0 : 0.0,
      duration: duration,
      curve: curve,
      child: child,
    );
  }
}
