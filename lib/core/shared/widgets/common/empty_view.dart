import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../constants/spacing.dart';
import '../../../app/theme/text_styles.dart';

class EmptyView extends StatelessWidget {
  final String? message;
  final IconData icon;
  final double iconSize;
  final bool animate;

  const EmptyView({
    super.key,
    this.message,
    this.icon = Icons.inbox_outlined,
    this.iconSize = 64,
    this.animate = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    Widget content = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: iconSize,
          color: colors.outline.withOpacity(.35),
        ),
        SizedBox(height: AppSpacing.spaceMD),
        Text(
          message ?? 'no_data'.tr(),
          textAlign: TextAlign.center,
          style: AppTextStyles.caption.copyWith(
            color: colors.onSurface.withOpacity(.7),
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
      ],
    );

    if (!animate) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.spaceLG),
          child: content,
        ),
      );
    }

    // Fade + Slide animation
    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppSpacing.spaceLG),
        child: TweenAnimationBuilder<double>(
          curve: Curves.easeOut,
          tween: Tween(begin: 0, end: 1),
          duration: const Duration(milliseconds: 300),
          builder: (context, value, child) {
            return Transform.translate(
              offset: Offset(0, 10 * (1 - value)),
              child: Opacity(
                opacity: value,
                child: child,
              ),
            );
          },
          child: content,
        ),
      ),
    );
  }
}
