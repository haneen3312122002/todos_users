import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants/colors.dart';
import '../constants/fonts.dart';

class AppTextStyles {
  //  Base text style
  static TextStyle get base =>
      TextStyle(fontFamily: AppFonts.primaryFont, color: AppColors.textPrimary);

  //  Title (Poppins, Bold, 24sp)
  static TextStyle get title =>
      base.copyWith(fontSize: 24.sp, fontWeight: FontWeight.bold);

  //  Body (Poppins, Regular, 24sp)
  static TextStyle get body =>
      base.copyWith(fontSize: 24.sp, fontWeight: FontWeight.normal);

  //  Caption (smaller)
  static TextStyle get caption => base.copyWith(
    fontSize: 14.sp,
    color: AppColors.textPrimary.withOpacity(0.7),
  );

  //  Error text
  static TextStyle get error =>
      base.copyWith(fontSize: 14.sp, color: AppColors.error);

  //  Link with ThemeData
  static TextTheme get textTheme =>
      TextTheme(headlineLarge: title, bodyLarge: body, bodyMedium: caption);
}
