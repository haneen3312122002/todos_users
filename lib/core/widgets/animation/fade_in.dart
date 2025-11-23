import 'package:flutter/material.dart';

class FadeIn extends StatelessWidget {
  final Widget child;
  final Duration duration;
  final Duration? delay;
  final Curve curve;
  final double begin;
  final double end;

  const FadeIn({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 400),
    this.delay = Duration.zero,
    this.curve = Curves.easeOut,
    this.begin = 0.0,
    this.end = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: begin, end: end),
      duration: duration,
      curve: curve,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: child,
        );
      },
      child: child,
    );
  }
}
