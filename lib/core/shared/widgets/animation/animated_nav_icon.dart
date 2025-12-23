import 'package:flutter/material.dart';

class AnimatedNavIcon extends StatelessWidget {
  final IconData icon;
  final bool isActive;

  const AnimatedNavIcon({
    super.key,
    required this.icon,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: isActive ? 1.2 : 1.0, //
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
      child: Icon(icon),
    );
  }
}
