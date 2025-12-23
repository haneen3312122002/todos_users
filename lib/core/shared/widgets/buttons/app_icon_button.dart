import 'package:flutter/material.dart';

class AppIconButton extends StatefulWidget {
  final VoidCallback? onTap;
  final IconData icon;

  final Color? backgroundColor;
  final Color? iconColor;

  final double? size;
  final double? iconSize;

  final bool isCircular;

  const AppIconButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.backgroundColor,
    this.iconColor,
    this.size,
    this.iconSize,
    this.isCircular = true,
  });

  @override
  State<AppIconButton> createState() => _AppIconButtonState();
}

class _AppIconButtonState extends State<AppIconButton>
    with SingleTickerProviderStateMixin {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final double buttonSize = widget.size ?? 42;
    final double iconSize = widget.iconSize ?? 20;

    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _pressed ? 0.90 : 1.0,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutQuad,
          height: buttonSize,
          width: buttonSize,
          decoration: BoxDecoration(
            shape: widget.isCircular ? BoxShape.circle : BoxShape.rectangle,
            borderRadius: widget.isCircular ? null : BorderRadius.circular(12),

            // خلفية ناعمة متماشية مع الثيم
            color: widget.backgroundColor ??
                theme.colorScheme.surface.withOpacity(0.92),

            // شادو بسيط يعطي بُعد
            boxShadow: [
              BoxShadow(
                color: theme.colorScheme.primary.withOpacity(0.12),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Icon(
            widget.icon,
            size: iconSize,
            color: widget.iconColor ?? theme.colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
