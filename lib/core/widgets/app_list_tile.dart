import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../theme/text_styles.dart';

/// مكوّن تفاعلي قابل للضغط، يمكن استخدامه داخل أو خارج الكارد.
/// مسؤول عن التفاعل (onTap) والعرض المنسق للنصوص والأيقونات.
class AppListTile extends StatelessWidget {
  final Widget? leading;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final Color? tileColor;

  const AppListTile({
    super.key,
    this.leading,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.tileColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      leading: leading,
      title: Text(
        title,
        style: AppTextStyles.body.copyWith(
          fontWeight: FontWeight.w600,
          color:
              theme.listTileTheme.titleTextStyle?.color ??
              AppColors.textPrimary,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              style: AppTextStyles.caption.copyWith(
                color:
                    theme.listTileTheme.subtitleTextStyle?.color ??
                    AppColors.textPrimary,
              ),
            )
          : null,
      trailing: trailing,
      tileColor: tileColor ?? theme.listTileTheme.tileColor,
      shape: theme.listTileTheme.shape,
      contentPadding: theme.listTileTheme.contentPadding,
      iconColor: theme.listTileTheme.iconColor,
      onTap: onTap, // ✅ التفاعل موجود هنا فقط
    );
  }
}
