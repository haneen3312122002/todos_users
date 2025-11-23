import 'package:flutter/material.dart';

class AnimatedNavIcon extends StatelessWidget {
  final IconData icon;
  final bool isActive;

  const AnimatedNavIcon({
    required this.icon,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: isActive ? 1.2 : 1.0, // تكبير بسيط عند التحديد
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
      child: Icon(icon),
    );
  }
}
