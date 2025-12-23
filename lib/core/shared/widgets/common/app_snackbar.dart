import 'package:flutter/material.dart';

enum SnackbarType { normal, success, error }

class AppSnackbar {
  static void show(
    BuildContext context,
    String message, {
    SnackbarType type = SnackbarType.normal,
  }) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    // تحديد اللون حسب نوع الرسالة
    Color bg;
    IconData icon;

    switch (type) {
      case SnackbarType.success:
        bg = colors.primaryContainer.withOpacity(.95);
        icon = Icons.check_circle_rounded;
        break;
      case SnackbarType.error:
        bg = colors.errorContainer.withOpacity(.95);
        icon = Icons.error_rounded;
        break;
      default:
        bg = colors.surfaceContainerHighest.withOpacity(.95);
        icon = Icons.info_rounded;
    }

    // تنظيف أي سناكبار قديم
    ScaffoldMessenger.of(context).removeCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 6,
        backgroundColor: bg,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        duration: const Duration(seconds: 2),

        // المحتوى الجديد
        content: Row(
          children: [
            Icon(icon, color: colors.onSurface),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                message,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colors.onSurface,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
