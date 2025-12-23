import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:notes_tasks/core/shared/constants/spacing.dart';
import 'package:notes_tasks/core/app/theme/text_styles.dart';
import 'package:notes_tasks/core/shared/providers/expandable_text_provider.dart';

class ExpandableText extends ConsumerWidget {

  final String id;


  final String text;


  final int trimLines;


  final TextStyle? style;


  final TextAlign? textAlign;


  final bool enableToggle;

  const ExpandableText({
    super.key,
    required this.id,
    required this.text,
    this.trimLines = 2,
    this.style,
    this.textAlign,
    this.enableToggle = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    final textStyle = style ??
        AppTextStyles.caption.copyWith(
          color: theme.colorScheme.onSurface,
        );


    final bool canOverflow =
        text.length > 80 || text.split('\n').length > trimLines;


    if (!enableToggle || !canOverflow) {
      return Text(
        text,
        maxLines: trimLines,
        overflow: TextOverflow.ellipsis,
        style: textStyle,
        textAlign: textAlign,
      );
    }


    final isExpanded = ref.watch(expandableTextStateProvider(id));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          maxLines: isExpanded ? null : trimLines,
          overflow: isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
          style: textStyle,
          textAlign: textAlign,
        ),
        SizedBox(height: AppSpacing.spaceXS),
        GestureDetector(
          onTap: () {
            final notifier = ref.read(expandableTextStateProvider(id).notifier);
            notifier.state = !isExpanded;
          },
          child: Text(
            isExpanded ? 'show_less'.tr() : 'show_more'.tr(),
            style: AppTextStyles.caption.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}