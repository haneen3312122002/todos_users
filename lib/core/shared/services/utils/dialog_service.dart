import 'package:flutter/material.dart';
import 'package:notes_tasks/core/shared/constants/spacing.dart';
import 'package:notes_tasks/core/app/theme/text_styles.dart';

class DialogService {

  static Future<bool> showConfirmDialog({
    required BuildContext context,
    required String title,
    required String message,
    required String cancelLabel,
    required String confirmLabel,
    Color? confirmColor,
    bool dismissible = true,
  }) async {
    final theme = Theme.of(context);

    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: dismissible,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          backgroundColor: theme.colorScheme.surface,
          title: Text(
            title,
            style: AppTextStyles.title.copyWith(
              color: theme.colorScheme.primary,
            ),
          ),
          content: Padding(
            padding: EdgeInsets.only(top: AppSpacing.spaceMD),
            child: Text(
              message,
              style: AppTextStyles.body.copyWith(
                color: theme.colorScheme.onSurface,
              ),
            ),
          ),
          actionsPadding: EdgeInsets.only(
            right: AppSpacing.spaceMD,
            bottom: AppSpacing.spaceMD,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop(false);
              },
              child: Text(
                cancelLabel,
                style: AppTextStyles.body.copyWith(
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop(true);
              },
              child: Text(
                confirmLabel,
                style: AppTextStyles.body.copyWith(
                  color: confirmColor ?? theme.colorScheme.error,
                ),
              ),
            ),
          ],
        );
      },
    );


    return result ?? false;
  }
}