import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../shared/constants/colors.dart';
import 'text_styles.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.background,
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.primary,
      onPrimary: Colors.white,
      secondary: AppColors.secondary,
      onSecondary: Colors.white,
      error: AppColors.error,
      onError: Colors.white,
      surface: AppColors.surface,
      onSurface: AppColors.textPrimary,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.background,
      foregroundColor: AppColors.textPrimary,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: AppTextStyles.title.copyWith(
        color: AppColors.textPrimary,
        fontSize: 16.sp,
      ),
    ),
    textTheme: AppTextStyles.textTheme.apply(
      bodyColor: AppColors.textPrimary,
      displayColor: AppColors.textPrimary,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        textStyle: AppTextStyles.body.copyWith(
          fontWeight: FontWeight.w600,
          color: Colors.white,
          fontSize: 14.sp,
        ),
        padding: EdgeInsets.symmetric(
          vertical: 10.h,
          horizontal: 18.w,
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.surface,
      contentPadding: EdgeInsets.symmetric(
        horizontal: 12.w,
        vertical: 10.h,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: const BorderSide(
          color: AppColors.primary,
          width: 1.5,
        ),
      ),
      hintStyle: AppTextStyles.caption.copyWith(
        color: AppColors.textPrimary.withOpacity(0.4),
      ),
      labelStyle: AppTextStyles.body.copyWith(
        fontSize: 13.sp,
        color: AppColors.textPrimary,
      ),
    ),
    cardTheme: CardThemeData(
      color: AppColors.surface,
      shadowColor: AppColors.border.withOpacity(0.4),
      elevation: 3,
      margin: EdgeInsets.symmetric(
        horizontal: 12.w,
        vertical: 8.h,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
        side: const BorderSide(color: AppColors.border),
      ),
    ),
    listTileTheme: ListTileThemeData(
      titleTextStyle: AppTextStyles.body.copyWith(
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
      subtitleTextStyle: AppTextStyles.caption.copyWith(
        color: AppColors.textPrimary.withOpacity(0.8),
      ),
      iconColor: AppColors.primary,
      tileColor: AppColors.surface,
      contentPadding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 8.h,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      elevation: 4,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.darkBackground,
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: AppColors.primary,
      onPrimary: Colors.white,
      secondary: AppColors.secondary,
      onSecondary: Colors.black,
      error: AppColors.error,
      onError: Colors.white,
      surface: AppColors.darkSurface,
      onSurface: AppColors.textDark,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.darkBackground,
      foregroundColor: AppColors.textDark,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: AppTextStyles.title.copyWith(
        color: AppColors.textDark,
        fontSize: 16.sp,
      ),
    ),
    textTheme: AppTextStyles.textTheme.apply(
      bodyColor: AppColors.textDark,
      displayColor: AppColors.textDark,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        disabledBackgroundColor: AppColors.darkSurface.withOpacity(0.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        textStyle: AppTextStyles.body.copyWith(
          fontWeight: FontWeight.w600,
          color: Colors.white,
          fontSize: 14.sp,
        ),
        padding: EdgeInsets.symmetric(
          vertical: 10.h,
          horizontal: 18.w,
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.darkSurface,
      contentPadding: EdgeInsets.symmetric(
        horizontal: 12.w,
        vertical: 10.h,
      ),
      hintStyle: AppTextStyles.caption.copyWith(
        color: AppColors.textDark.withOpacity(0.5),
      ),
      labelStyle: AppTextStyles.body.copyWith(
        color: AppColors.textDark,
        fontSize: 13.sp,
      ),
      floatingLabelStyle: AppTextStyles.body.copyWith(
        color: AppColors.textDark.withOpacity(0.9),
        fontSize: 13.sp,
      ),
      counterStyle: AppTextStyles.caption.copyWith(color: AppColors.textDark),
      helperStyle: AppTextStyles.caption.copyWith(color: AppColors.textDark),
      prefixStyle: AppTextStyles.caption.copyWith(color: AppColors.textDark),
      suffixStyle: AppTextStyles.caption.copyWith(color: AppColors.textDark),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: BorderSide(color: AppColors.darkBorder),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: BorderSide(color: AppColors.darkBorder),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.primary, width: 1.5),
      ),
      prefixIconColor: AppColors.textDark,
      suffixIconColor: AppColors.textDark,
    ),
    cardTheme: CardThemeData(
      color: AppColors.darkSurface,
      shadowColor: Colors.black.withOpacity(0.7),
      elevation: 5,
      margin: EdgeInsets.symmetric(
        horizontal: 12.w,
        vertical: 8.h,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
        side: BorderSide(color: AppColors.darkBorder),
      ),
    ),
    listTileTheme: ListTileThemeData(
      titleTextStyle: AppTextStyles.body.copyWith(
        fontWeight: FontWeight.w600,
        color: AppColors.textDark,
      ),
      subtitleTextStyle: AppTextStyles.caption.copyWith(
        color: AppColors.textDark.withOpacity(0.7),
      ),
      iconColor: AppColors.primary,
      tileColor: AppColors.darkSurface,
      contentPadding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 8.h,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.textDark,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      elevation: 6,
    ),
    dividerTheme: DividerThemeData(
      color: AppColors.darkBorder,
      thickness: 0.5,
    ),
  );
}
