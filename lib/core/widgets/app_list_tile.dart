import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../theme/text_styles.dart';
import 'animation/fade_in.dart';
import 'animation/slide_in.dart';

class AppListTile extends StatelessWidget {
  final Widget? leading;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final Color? tileColor;

  final bool animate;
  final Duration animationDuration;
  final Offset slideFrom;

  const AppListTile({
    super.key,
    this.leading,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.tileColor,
    this.animate = true,
    this.animationDuration = const Duration(milliseconds: 200),
    this.slideFrom = const Offset(0, 5),
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget tile = ListTile(
      leading: leading,
      title: Text(
        title,
        style: AppTextStyles.body.copyWith(
          fontWeight: FontWeight.w600,
          color: theme.listTileTheme.titleTextStyle?.color ??
              AppColors.textPrimary,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              style: AppTextStyles.caption.copyWith(
                color: theme.listTileTheme.subtitleTextStyle?.color ??
                    AppColors.textPrimary,
              ),
            )
          : null,
      trailing: trailing,
      tileColor: tileColor ?? theme.listTileTheme.tileColor,
      shape: theme.listTileTheme.shape,
      contentPadding: theme.listTileTheme.contentPadding,
      iconColor: theme.listTileTheme.iconColor,
      onTap: onTap,
    );

    if (!animate) return tile;

    return FadeIn(
      duration: animationDuration,
      child: SlideIn(
        from: slideFrom,
        duration: animationDuration,
        child: tile,
      ),
    );
  }
}
