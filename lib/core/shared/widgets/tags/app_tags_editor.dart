
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:notes_tasks/core/shared/constants/spacing.dart';
import 'package:notes_tasks/core/app/theme/text_styles.dart';
import 'package:notes_tasks/core/shared/widgets/tags/app_tag_chip.dart';





class AppTagsEditor extends StatelessWidget {
  final List<String> tags;

  final TextEditingController controller;
  final VoidCallback onAddTag;
  final ValueChanged<int> onRemoveTagAt;

  final String? emptyHintKey;
  final String labelKey;
  final String hintKey;
  final String addTooltipKey;

  final double? spacing;
  final double? runSpacing;

  const AppTagsEditor({
    super.key,
    required this.tags,
    required this.controller,
    required this.onAddTag,
    required this.onRemoveTagAt,
    required this.labelKey,
    required this.hintKey,
    required this.addTooltipKey,
    this.emptyHintKey,
    this.spacing,
    this.runSpacing,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (tags.isNotEmpty)
          Wrap(
            spacing: spacing ?? AppSpacing.spaceSM,
            runSpacing: runSpacing ?? AppSpacing.spaceSM,
            children: List.generate(tags.length, (index) {
              final tag = tags[index];
              return AppTagChip(
                label: tag,
                onDeleted: () => onRemoveTagAt(index),
              );
            }),
          )
        else if (emptyHintKey != null)
          Text(
            emptyHintKey!.tr(),
            style: AppTextStyles.caption,
          ),
        if (tags.isNotEmpty || emptyHintKey != null)
          SizedBox(height: AppSpacing.spaceMD),


        Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  labelText: labelKey.tr(),
                  hintText: hintKey.tr(),
                ),
                textInputAction: TextInputAction.done,
                onSubmitted: (_) => onAddTag(),
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              onPressed: onAddTag,
              icon: const Icon(Icons.add),
              tooltip: addTooltipKey.tr(),
              color: theme.colorScheme.primary,
            ),
          ],
        ),
      ],
    );
  }
}