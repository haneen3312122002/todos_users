import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../constants/colors.dart';
import '../constants/spacing.dart';
import '../theme/text_styles.dart';

class EmptyView extends StatelessWidget {
  final String? message;
  final IconData icon;

  const EmptyView({super.key, this.message, this.icon = Icons.inbox_outlined});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppSpacing.spaceLG),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 60, color: AppColors.border),
            SizedBox(height: AppSpacing.spaceMD),
            Text(
              message ?? 'no_data'.tr(),
              textAlign: TextAlign.center,
              style: AppTextStyles.caption,
            ),
          ],
        ),
      ),
    );
  }
}
