import 'package:flutter/material.dart';
import '../constants/spacing.dart';

/// مكوّن عرضي فقط (Presentation Widget)
/// مسؤول فقط عن الشكل العام للكارد دون أي تفاعل.
class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;

  const AppCard({super.key, required this.child, this.padding});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
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
  }
}
