import 'package:flutter/material.dart';
import 'animation/fade_in.dart';

class AppFAB extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final String? tooltip;

  final bool animate;

  const AppFAB(
      {super.key,
      required this.onPressed,
      this.icon = Icons.add,
      this.tooltip,
      this.animate = true});

  @override
  Widget build(BuildContext context) {
    Widget fab = FloatingActionButton(
      onPressed: onPressed,
      tooltip: tooltip,
      child: Icon(icon, size: 28),
    );

    if (!animate) return fab;

    return FadeIn(
      duration: const Duration(milliseconds: 220),
      child: TweenAnimationBuilder<double>(
        duration: const Duration(milliseconds: 220),
        tween: Tween(begin: 0.8, end: 1.0),
        curve: Curves.easeOutBack,
        builder: (context, scale, child) {
          return Transform.scale(
            scale: scale,
            child: child,
          );
        },
        child: fab,
      ),
    );
  }
}
