
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:notes_tasks/core/shared/constants/spacing.dart';
import 'package:notes_tasks/core/app/theme/text_styles.dart';
import 'package:notes_tasks/core/shared/widgets/tags/app_tag_chip.dart';





class AppTagsWrap extends StatelessWidget {
  final List<String> tags;
  final String? emptyTextKey;


  final double? spacing;
  final double? runSpacing;

  const AppTagsWrap({
    super.key,
    required this.tags,
    this.emptyTextKey,
    this.spacing,
    this.runSpacing,
  });

  @override
  Widget build(BuildContext context) {
    if (tags.isEmpty && emptyTextKey != null) {
      return Text(
        emptyTextKey!.tr(),
        style: AppTextStyles.caption,
      );
    }

    if (tags.isEmpty) {
      return const SizedBox.shrink();
    }

    return Wrap(
      spacing: spacing ?? AppSpacing.spaceSM,
      runSpacing: runSpacing ?? AppSpacing.spaceSM,
      children: tags
          .map(
            (t) => AppTagChip(label: t),
          )
          .toList(),
    );
  }
}