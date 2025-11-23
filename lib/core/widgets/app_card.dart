import 'package:flutter/material.dart';
import '../constants/spacing.dart';
import 'animation/fade_in.dart';
import 'animation/slide_in.dart';

class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;

  final bool animate;
  final Duration animationDuration;
  final Offset slideFrom; // e.g. Offset(0, 10) → from bottom

  const AppCard({
    super.key,
    required this.child,
    this.padding,
    this.animate = true,
    this.animationDuration = const Duration(milliseconds: 250),
    this.slideFrom = const Offset(0, 10),
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget content = Card(
      elevation: theme.cardTheme.elevation,
      margin: theme.cardTheme.margin,
      color: theme.cardTheme.color,
      shape: theme.cardTheme.shape,
      shadowColor: theme.cardTheme.shadowColor,
      child: Padding(
        padding: padding ?? EdgeInsets.all(AppSpacing.sectionPadding),
        child: child,
      ),
    );

    if (!animate) return content;

    return FadeIn(
      duration: animationDuration,
      child: SlideIn(
        from: slideFrom,
        duration: animationDuration,
        child: content,
      ),
    );
  }
}
