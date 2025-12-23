import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../app/theme/text_styles.dart';
import '../animation/fade_in.dart';
import '../animation/slide_in.dart';

class AppPrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool isLoading;
  final IconData? icon;

  final bool animate;
  final Duration animationDuration;
  final Offset slideFrom;
  final Duration? delay;

  const AppPrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.icon,
    this.animate = true,
    this.animationDuration = const Duration(milliseconds: 220),
    this.slideFrom = const Offset(0, 8),
    this.delay,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    // نضبط الشكل العام للزر (عرض + ارتفاع)
    Widget button = SizedBox(
      width: double.infinity,
      height: 46.h,
      child: ElevatedButton(
        style: theme.elevatedButtonTheme.style?.copyWith(
          elevation: WidgetStateProperty.all(2),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14.r),
            ),
          ),
        ),
        onPressed: isLoading ? null : onPressed,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 180),
          switchInCurve: Curves.easeOut,
          switchOutCurve: Curves.easeIn,
          child: isLoading
              ? SizedBox(
                  key: const ValueKey('loading'),
                  height: 22.h,
                  width: 22.h,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      colors.onPrimary,
                    ),
                  ),
                )
              : Row(
                  key: const ValueKey('content'),
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (icon != null) ...[
                      Icon(
                        icon,
                        size: 20.sp,
                        color: colors.onPrimary,
                      ),
                      SizedBox(width: 8.w),
                    ],
                    Text(
                      label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.body.copyWith(
                        fontWeight: FontWeight.w600,
                        color: colors.onPrimary,
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );

    if (!animate) return button;

    return FadeIn(
      duration: animationDuration,
      child: SlideIn(
        from: slideFrom,
        duration: animationDuration,
        child: button,
      ),
    );
  }
}
