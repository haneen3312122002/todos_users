import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:notes_tasks/core/shared/constants/spacing.dart';
import 'package:notes_tasks/core/shared/widgets/cards/app_card.dart';
import 'package:notes_tasks/core/app/theme/text_styles.dart';
import 'package:notes_tasks/modules/profile/domain/entities/profile_entity.dart';

class AdminProfileSections extends StatelessWidget {
  final ProfileEntity profile;

  const AdminProfileSections({
    super.key,
    required this.profile,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'admin_tools_title'.tr(),
                style: AppTextStyles.caption.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: AppSpacing.spaceSM),
              Text(
                'admin_tools_hint'.tr(),
                style: AppTextStyles.caption,
              ),
              SizedBox(height: AppSpacing.spaceSM),
            ],
          ),
        ),
      ],
    );
  }
}