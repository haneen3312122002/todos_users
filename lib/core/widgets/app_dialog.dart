import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants/colors.dart';
import '../theme/text_styles.dart';
import '../constants/spacing.dart';

class AppDialog extends StatelessWidget {
  final String? title;
  final Widget content;
  final double? width;
  final bool dismissible;

  const AppDialog({
    super.key,
    this.title,
    required this.content,
    this.width,
    this.dismissible = true,
  });

  static Future<T?> show<T>({
    required BuildContext context,
    String? title,
    required Widget content,
    bool dismissible = true,
    double? width,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: dismissible,
      builder: (_) => AppDialog(
        title: title,
        content: content,
        width: width,
        dismissible: dismissible,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      insetPadding: EdgeInsets.all(20.w),
      backgroundColor: theme.colorScheme.surface,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: width ?? 380.w),
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.spaceLG),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (title != null) ...[
                Text(
                  title!,
                  style: AppTextStyles.title.copyWith(
                    color: theme.colorScheme.primary,
                  ),
                ),
                SizedBox(height: AppSpacing.spaceMD),
                Divider(color: AppColors.border),
                SizedBox(height: AppSpacing.spaceMD),
              ],
              content,
            ],
          ),
        ),
      ),
    );
  }
}
