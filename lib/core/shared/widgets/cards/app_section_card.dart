import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:notes_tasks/core/shared/constants/spacing.dart';
import 'package:notes_tasks/core/app/theme/text_styles.dart';
import 'package:notes_tasks/core/shared/widgets/cards/app_card.dart';

class ProfileSectionCard extends StatelessWidget {
  final String titleKey;
  final Widget child;
  final List<Widget> actions;

  /// لو true يلف الـ child بـ AppCard، لو false يعرضه مباشر
  final bool useCard;

  const ProfileSectionCard({
    super.key,
    required this.titleKey,
    required this.child,
    this.actions = const [],
    this.useCard = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasActions = actions.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // ===== Header (العنوان + الأكشنات) =====
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // العنوان
            Text(
              titleKey.tr(),
              style: AppTextStyles.title.copyWith(
                fontSize: 16, // شوي أصغر من الـ page title
                fontWeight: FontWeight.w700,
                color: theme.colorScheme.onSurface,
              ),
            ),

            const Spacer(),

            // الأكشنز (زر إضافة / تعديل الخ)
            if (hasActions)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (int i = 0; i < actions.length; i++) ...[
                    actions[i],
                    if (i != actions.length - 1)
                      SizedBox(width: AppSpacing.spaceXS),
                  ],
                ],
              ),
          ],
        ),

        SizedBox(height: AppSpacing.spaceSM),

        // ===== المحتوى =====
        useCard
            ? AppCard(child: child)
            : Padding(
                padding: EdgeInsets.only(
                  bottom: AppSpacing.spaceMD,
                ),
                child: child,
              ),
      ],
    );
  }
}
