import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants/colors.dart';
import '../theme/text_styles.dart';
import '../constants/spacing.dart';
import 'animation/fade_in.dart';

class AppDialog extends StatelessWidget {
  final String? title;
  final Widget content;
  final double? width;
  final bool dismissible;

  final bool animate;

  const AppDialog({
    super.key,
    this.title,
    required this.content,
    this.width,
    this.dismissible = true,
    this.animate = true,
  });

  static Future<T?> show<T>({
    required BuildContext context,
    String? title,
    required Widget content,
    bool dismissible = true,
    double? width,
    bool animate = true,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: dismissible,
      builder: (_) => AppDialog(
        title: title,
        content: content,
        width: width,
        dismissible: dismissible,
        animate: animate,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget dialogBody = Dialog(
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

    if (!animate) return dialogBody;

    // Scale + Fade
    return FadeIn(
      duration: const Duration(milliseconds: 200),
      child: TweenAnimationBuilder<double>(
        duration: const Duration(milliseconds: 200),
        tween: Tween(begin: 0.9, end: 1.0),
        curve: Curves.easeOutBack,
        builder: (context, scale, child) {
          return Transform.scale(
            scale: scale,
            child: child,
          );
        },
        child: dialogBody,
      ),
    );
  }
}
