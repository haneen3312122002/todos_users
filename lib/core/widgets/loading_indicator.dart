import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import '../constants/colors.dart';

class LoadingIndicator extends StatelessWidget {
  final double size;
  final bool withBackground;
  final String? message;

  const LoadingIndicator({
    super.key,
    this.size = 40,
    this.withBackground = false,
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    final loader = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: size.h,
          width: size.h,
          child: const CircularProgressIndicator(
            color: AppColors.primary,
            strokeWidth: 3,
          ),
        ),
        SizedBox(height: 12.h),
        Text(
          message ?? 'loading_msg'.tr(),
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );

    if (withBackground) {
      return Container(
        color: Colors.black.withOpacity(0.3),
        alignment: Alignment.center,
        child: loader,
      );
    }

    return Center(child: loader);
  }
}
