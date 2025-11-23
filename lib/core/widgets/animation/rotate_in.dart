import 'dart:math' as math;
import 'package:flutter/material.dart';

class RotateIn extends StatelessWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Curve curve;
  final double beginTurns;
  final double endTurns;

  const RotateIn({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 400),
    this.delay = Duration.zero,
    this.curve = Curves.easeOut,
    this.beginTurns = -0.25,
    this.endTurns = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: beginTurns, end: endTurns),
      duration: duration,
      curve: curve,
      builder: (context, value, child) {
        return Transform.rotate(
          angle: value * 2 * math.pi,
          child: child,
        );
      },
      child: child,
    );
  }
}
