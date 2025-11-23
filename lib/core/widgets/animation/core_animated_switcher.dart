import 'package:flutter/material.dart';

class CoreAnimatedSwitcher extends StatelessWidget {
  final Widget child;
  final Duration duration;
  final Curve switchInCurve;
  final Curve switchOutCurve;

  const CoreAnimatedSwitcher({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 250),
    this.switchInCurve = Curves.easeOut,
    this.switchOutCurve = Curves.easeIn,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: duration,
      switchInCurve: switchInCurve,
      switchOutCurve: switchOutCurve,
      transitionBuilder: (widget, animation) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.9, end: 1.0).animate(animation),
            child: widget,
          ),
        );
      },
      child: child,
    );
  }
}
