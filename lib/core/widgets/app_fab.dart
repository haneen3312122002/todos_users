import 'package:flutter/material.dart';
import 'animation/fade_in.dart';
import 'animation/shake_animation.dart';

class AppFAB extends StatefulWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final String? tooltip;

  final bool animate;

  final bool enableShake;

  const AppFAB({
    super.key,
    required this.onPressed,
    this.icon = Icons.add,
    this.tooltip,
    this.animate = true,
    this.enableShake = true,
  });

  @override
  State<AppFAB> createState() => _AppFABState();
}

class _AppFABState extends State<AppFAB> {
  bool _shake = false;

  void _triggerShake() {
    if (!widget.enableShake) return;

    setState(() => _shake = true);

    Future.delayed(const Duration(milliseconds: 350), () {
      if (mounted) setState(() => _shake = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget fab = FloatingActionButton(
      onPressed: () {
        _triggerShake();
        widget.onPressed();
      },
      tooltip: widget.tooltip,
      child: Icon(widget.icon, size: 28),
    );

    fab = ShakeAnimation(
      trigger: _shake,
      offset: 8,
      duration: const Duration(milliseconds: 300),
      child: fab,
    );

    if (widget.animate) {
      fab = FadeIn(
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

    return fab;
  }
}
