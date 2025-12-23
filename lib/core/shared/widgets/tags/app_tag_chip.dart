import 'package:flutter/material.dart';
import 'package:notes_tasks/core/app/theme/text_styles.dart';

class AppTagChip extends StatelessWidget {
  final String label;
  final VoidCallback? onDeleted;

  const AppTagChip({
    super.key,
    required this.label,
    this.onDeleted,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (onDeleted != null) {
      return InputChip(
        label: Text(
          label,
          style: AppTextStyles.caption,
        ),
        onDeleted: onDeleted,
        deleteIconColor: theme.colorScheme.error,
      );
    }

    return Chip(
      label: Text(
        label,
        style: AppTextStyles.caption,
      ),
      backgroundColor:
          theme.colorScheme.surfaceContainerHighest.withOpacity(0.4),
    );
  }
}
