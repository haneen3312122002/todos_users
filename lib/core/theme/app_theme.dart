import 'package:flutter/material.dart';
import '../constants/colors.dart';
import 'text_styles.dart';

class AppTheme {
  //  Light Theme
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    // General Colors
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.background,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.light,
      secondary: AppColors.secondary,
      onSecondary: Colors.white,
      error: AppColors.error,
      surface: AppColors.surface,
      onSurface: AppColors.textPrimary,
    ),
    // AppBar Theme
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
    // Text Theme
    textTheme: AppTextStyles.textTheme,
    // Elevated Button Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: AppTextStyles.body.copyWith(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
      ),
    ),
    // Input Field Theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.surface,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.border),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.primary, width: 1.5),
      ),
      hintStyle: const TextStyle(color: Colors.grey),
    ),
    // Cards & ListTiles
    cardTheme: CardThemeData(
      color: AppColors.surface,
      shadowColor: AppColors.border,
      elevation: 3,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: AppColors.border),
      ),
    ),
    listTileTheme: ListTileThemeData(
      titleTextStyle: AppTextStyles.body.copyWith(fontWeight: FontWeight.w600),
      subtitleTextStyle: AppTextStyles.caption.copyWith(
        color: AppColors.textPrimary,
      ),
      iconColor: AppColors.primary,
      tileColor: AppColors.surface,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),

    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,

    // General Colors
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.darkBackground,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.dark,
      secondary: AppColors.secondary,
      onSecondary: Colors.black,
      error: AppColors.error,
      surface: AppColors.darkSurface,
      onSurface: AppColors.textDark,
      background: AppColors.darkBackground,
      onBackground: AppColors.textDark,
    ),

    // AppBar Theme
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.darkSurface,
      foregroundColor: AppColors.textDark,
      elevation: 1,
      centerTitle: true,
      titleTextStyle: AppTextStyles.body.copyWith(
        color: AppColors.textDark,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),

    // Text Theme
    textTheme: AppTextStyles.textTheme,

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textDark,
        disabledBackgroundColor: AppColors.darkSurface.withOpacity(0.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: AppTextStyles.body.copyWith(
          fontWeight: FontWeight.bold,
          color: AppColors.textDark,
        ),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
      ),
    ),

    // Input Field Theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.darkSurface,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      hintStyle: TextStyle(color: AppColors.textDark.withOpacity(0.5)),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: AppColors.darkBorder),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: AppColors.darkBorder),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.primary, width: 1.5),
      ),
    ),

    // Cards & ListTiles
    cardTheme: CardThemeData(
      color: AppColors.darkSurface,
      shadowColor: Colors.black.withOpacity(0.7),
      elevation: 5,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
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
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),

    // Floating Action Button
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.textDark,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 6,
    ),

    // Divider (الخط الفاصل)
    dividerTheme: DividerThemeData(color: AppColors.darkBorder, thickness: 0.5),
  );
}
