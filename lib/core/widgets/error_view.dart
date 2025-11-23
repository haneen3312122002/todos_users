import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import '../constants/colors.dart';
import '../constants/spacing.dart';
import '../theme/text_styles.dart';
import 'primary_button.dart';
import 'animation/fade_in.dart';
import 'animation/slide_in.dart';

class ErrorView extends StatelessWidget {
  final String? message;
  final VoidCallback? onRetry;
  final bool fullScreen;

  /// Animate error view appearance.
  final bool animate;

  const ErrorView({
    super.key,
    this.message,
    this.onRetry,
    this.fullScreen = true,
    this.animate = true,
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

    Widget view = fullScreen
        ? Center(
            child: Padding(
              padding: EdgeInsets.all(AppSpacing.screenHorizontal),
              child: content,
            ),
          )
        : Padding(
            padding: EdgeInsets.all(AppSpacing.spaceMD),
            child: content,
          );

    if (!animate) return view;

    return FadeIn(
      duration: const Duration(milliseconds: 220),
      child: SlideIn(
        from: const Offset(0, 10),
        duration: const Duration(milliseconds: 220),
        child: view,
      ),
    );
  }
}
