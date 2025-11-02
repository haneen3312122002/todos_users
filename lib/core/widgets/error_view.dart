import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import '../constants/colors.dart';
import '../constants/spacing.dart';
import '../theme/text_styles.dart';
import 'primary_button.dart';

class ErrorView extends StatelessWidget {
  final String? message;

  final VoidCallback? onRetry;

  final bool fullScreen;

  const ErrorView({
    super.key,
    this.message,
    this.onRetry,
    this.fullScreen = true,
  });

  @override
  Widget build(BuildContext context) {
    final content = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.error_outline,
          color: AppColors.error,
          size: fullScreen ? 80.h : 40.h,
        ),
        SizedBox(height: AppSpacing.spaceMD),
        Text(
          message ?? 'error_general'.tr(),
          textAlign: TextAlign.center,
          style: AppTextStyles.body.copyWith(color: AppColors.error),
        ),
        if (onRetry != null) ...[
          SizedBox(height: AppSpacing.spaceLG),
          AppPrimaryButton(
            label: 'retry'.tr(),
            onPressed: onRetry!,
            icon: Icons.refresh,
          ),
        ],
      ],
    );

    return fullScreen
        ? Center(
            child: Padding(
              padding: EdgeInsets.all(AppSpacing.screenHorizontal),
              child: content,
            ),
          )
        : Padding(padding: EdgeInsets.all(AppSpacing.spaceMD), child: content);
  }
}
