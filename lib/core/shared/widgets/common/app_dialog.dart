import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:notes_tasks/core/shared/constants/spacing.dart';
import 'package:notes_tasks/core/app/theme/text_styles.dart';

class AppDialog extends StatelessWidget {
  final String? title;
  final Widget content;
  final bool dismissible;
  final double? width;

  const AppDialog({
    super.key,
    this.title,
    required this.content,
    this.dismissible = true,
    this.width,
  });

  static Future<T?> show<T>({
    required BuildContext context,
    String? title,
    required Widget content,
    bool dismissible = true,
    double? width,
  }) {
    return showGeneralDialog(
      context: context,
      barrierDismissible: dismissible,
      barrierLabel: '',
      transitionDuration: const Duration(milliseconds: 220),
      pageBuilder: (_, __, ___) {
        return Center(
          child: AppDialog(
            title: title,
            content: content,
            dismissible: dismissible,
            width: width,
          ),
        );
      },
      transitionBuilder: (_, animation, __, child) {
        return FadeTransition(
          opacity: CurvedAnimation(
            parent: animation,
            curve: Curves.easeOut,
          ),
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.92, end: 1.0).animate(
              CurvedAnimation(
                parent: animation,
                curve: Curves.easeOutBack,
              ),
            ),
            child: child,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Dialog(
      insetPadding: const EdgeInsets.all(24),
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3), // 👈 Blur ناعم جداً
          child: Container(
            constraints: BoxConstraints(maxWidth: width ?? 380),
            padding: EdgeInsets.all(AppSpacing.spaceLG),
            decoration: BoxDecoration(
              color: colors.surface.withOpacity(0.95),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: colors.outline.withOpacity(0.3),
              ),
              boxShadow: [
                BoxShadow(
                  color: colors.primary.withOpacity(0.15),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (title != null) ...[
                  Text(
                    title!,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.title.copyWith(
                      fontSize: 18,
                      color: colors.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: AppSpacing.spaceMD),
                  Divider(
                    color: colors.outline.withOpacity(0.2),
                    thickness: 1,
                    height: 1,
                  ),
                  SizedBox(height: AppSpacing.spaceMD),
                ],
                content,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
