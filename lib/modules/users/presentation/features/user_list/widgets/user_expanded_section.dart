import 'package:flutter/material.dart';
import 'package:notes_tasks/core/shared/constants/colors.dart';
import 'package:notes_tasks/core/shared/constants/spacing.dart';
import 'package:notes_tasks/core/app/theme/text_styles.dart';
import 'package:notes_tasks/modules/users/domain/entities/user_entity.dart';

class UserExpandedSection extends StatelessWidget {
  final UserEntity user;

  const UserExpandedSection({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.spaceMD,
        vertical: AppSpacing.spaceSM,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(color: AppColors.border, height: AppSpacing.spaceMD),
          _buildDetailRow(Icons.email_outlined, user.email),
          SizedBox(height: AppSpacing.spaceSM),
        ],
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String value) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.icon),
        SizedBox(width: AppSpacing.spaceSM),
        Expanded(
          child: Text(
            value,
            style: AppTextStyles.caption.copyWith(color: AppColors.textPrimary),
          ),
        ),
      ],
    );
  }
}