// lib/config/theme/app_theme.dart

import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_typography.dart';

class AppTheme {
  AppTheme._(); // приватный конструктор

  // ─── Light Theme ────────────────────────────────────────
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,

    // ColorScheme
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.light,
      surface: AppColors.surfaceLight,
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      error: AppColors.error,
    ),

    scaffoldBackgroundColor: AppColors.backgroundLight,

    // ─── AppBar ─────────────────────────────────────────
    appBarTheme: AppBarTheme(
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: Colors.transparent,
      foregroundColor: AppColors.textPrimary,
      centerTitle: false,
      titleTextStyle: AppTypography.heading3.copyWith(
        color: AppColors.textPrimary,
      ),
      iconTheme: const IconThemeData(
        color: AppColors.textPrimary,
        size: 24,
      ),
    ),

    // ─── Bottom Navigation ──────────────────────────────
    bottomNavigationBarTheme:
        const BottomNavigationBarThemeData(
      backgroundColor: AppColors.surfaceLight,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.textSecondary,
      type: BottomNavigationBarType.fixed,
      elevation: 10,
      showUnselectedLabels: true,
    ),

    // ─── Navigation Bar (Material 3) ────────────────────
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: AppColors.surfaceLight,
      indicatorColor:
          AppColors.primary.withOpacity(0.12),
      iconTheme:
          WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const IconThemeData(
              color: AppColors.primary);
        }
        return const IconThemeData(
            color: AppColors.textSecondary);
      }),
      labelTextStyle:
          WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppTypography.label
              .copyWith(color: AppColors.primary);
        }
        return AppTypography.label.copyWith(
            color: AppColors.textSecondary);
      }),
    ),

    // ─── Card ───────────────────────────────────────────
    cardTheme: CardThemeData(
      elevation: 2,
      shadowColor: AppColors.shadowLight,
      color: AppColors.surfaceLight,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      margin: const EdgeInsets.symmetric(
          horizontal: 0, vertical: 4),
    ),

    // ─── Elevated Button ────────────────────────────────
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        disabledBackgroundColor:
            AppColors.borderLight,
        disabledForegroundColor: AppColors.textHint,
        padding: const EdgeInsets.symmetric(
          horizontal: 32,
          vertical: 16,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        textStyle: AppTypography.buttonLarge,
        elevation: 2,
        shadowColor: AppColors.shadowLight,
      ),
    ),

    // ─── Text Button ────────────────────────────────────
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primary,
        textStyle: AppTypography.buttonMedium,
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
      ),
    ),

    // ─── Outlined Button ────────────────────────────────
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primary,
        side: const BorderSide(
          color: AppColors.primary,
          width: 1.5,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 32,
          vertical: 16,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        textStyle: AppTypography.buttonLarge,
      ),
    ),

    // ─── Input Decoration ───────────────────────────────
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor:
          AppColors.borderLight.withOpacity(0.5),
      hintStyle: AppTypography.bodyMedium.copyWith(
        color: AppColors.textHint,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(
          color: AppColors.borderLight,
          width: 1,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(
          color: AppColors.primary,
          width: 2,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(
          color: AppColors.error,
          width: 1,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(
          color: AppColors.error,
          width: 2,
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 16,
      ),
    ),

    // ─── Chip ───────────────────────────────────────────
    chipTheme: ChipThemeData(
      backgroundColor: AppColors.borderLight,
      selectedColor:
          AppColors.primary.withOpacity(0.15),
      labelStyle: AppTypography.bodySmall,
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      side: BorderSide.none,
    ),

    // ─── Divider ────────────────────────────────────────
    dividerTheme: const DividerThemeData(
      color: AppColors.divider,
      thickness: 1,
      space: 1,
    ),

    // ─── SnackBar ───────────────────────────────────────
    // ✅ ADDED from top code
    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),

    // ─── Dialog ─────────────────────────────────────────
    // ✅ ADDED from top code
    dialogTheme: DialogTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),

    // ─── Bottom Sheet ───────────────────────────────────
    // ✅ ADDED from top code
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
    ),

    // ─── Text Theme ─────────────────────────────────────
    textTheme: TextTheme(
      displayLarge: AppTypography.heading1,
      displayMedium: AppTypography.heading2,
      displaySmall: AppTypography.heading3,
      headlineMedium: AppTypography.heading4,
      headlineSmall: AppTypography.heading5,
      bodyLarge: AppTypography.bodyLarge,
      bodyMedium: AppTypography.bodyMedium,
      bodySmall: AppTypography.bodySmall,
      labelLarge: AppTypography.buttonLarge,
      labelMedium: AppTypography.label,
      labelSmall: AppTypography.caption,
    ),
  );

  // ─── Dark Theme ─────────────────────────────────────────
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,

    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.dark,
      surface: AppColors.surfaceDark,
      primary: AppColors.primaryLight,
      secondary: AppColors.secondary,
      error: AppColors.error,
    ),

    scaffoldBackgroundColor: AppColors.backgroundDark,

    appBarTheme: AppBarTheme(
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: Colors.transparent,
      foregroundColor: AppColors.textPrimaryDark,
      centerTitle: false,
      titleTextStyle: AppTypography.heading3.copyWith(
        color: AppColors.textPrimaryDark,
      ),
      iconTheme: const IconThemeData(
        color: AppColors.textPrimaryDark,
        size: 24,
      ),
    ),

    bottomNavigationBarTheme:
        const BottomNavigationBarThemeData(
      backgroundColor: AppColors.surfaceDark,
      selectedItemColor: AppColors.primaryLight,
      unselectedItemColor:
          AppColors.textSecondaryDark,
      type: BottomNavigationBarType.fixed,
      elevation: 10,
      showUnselectedLabels: true,
    ),

    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: AppColors.surfaceDark,
      indicatorColor:
          AppColors.primaryLight.withOpacity(0.15),
      iconTheme:
          WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const IconThemeData(
              color: AppColors.primaryLight);
        }
        return const IconThemeData(
            color: AppColors.textSecondaryDark);
      }),
    ),

    cardTheme: CardThemeData(
      elevation: 2,
      shadowColor: AppColors.shadowDark,
      color: AppColors.surfaceDark,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        disabledBackgroundColor: AppColors.borderDark,
        disabledForegroundColor: AppColors.textHint,
        padding: const EdgeInsets.symmetric(
          horizontal: 32,
          vertical: 16,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        textStyle: AppTypography.buttonLarge,
        elevation: 2,
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primaryLight,
        textStyle: AppTypography.buttonMedium,
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primaryLight,
        side: const BorderSide(
          color: AppColors.primaryLight,
          width: 1.5,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        textStyle: AppTypography.buttonLarge,
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor:
          AppColors.borderDark.withOpacity(0.5),
      hintStyle: AppTypography.bodyMedium.copyWith(
        color: AppColors.textHint,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(
          color: AppColors.borderDark,
          width: 1,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(
          color: AppColors.primaryLight,
          width: 2,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(
          color: AppColors.error,
          width: 1,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(
          color: AppColors.error,
          width: 2,
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 16,
      ),
    ),

    chipTheme: ChipThemeData(
      backgroundColor: AppColors.borderDark,
      selectedColor:
          AppColors.primaryLight.withOpacity(0.2),
      labelStyle: AppTypography.bodySmall.copyWith(
        color: AppColors.textPrimaryDark,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      side: BorderSide.none,
    ),

    dividerTheme: const DividerThemeData(
      color: AppColors.borderDark,
      thickness: 1,
      space: 1,
    ),

    // ─── SnackBar ───────────────────────────────────────
    // ✅ ADDED from top code
    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),

    // ─── Dialog ─────────────────────────────────────────
    // ✅ ADDED from top code
    dialogTheme: DialogTheme(
      backgroundColor: const Color(0xFF1E1E1E),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),

    // ─── Bottom Sheet ───────────────────────────────────
    // ✅ ADDED from top code
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Color(0xFF1E1E1E),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
    ),

    textTheme: TextTheme(
      displayLarge: AppTypography.heading1
          .copyWith(color: AppColors.textPrimaryDark),
      displayMedium: AppTypography.heading2
          .copyWith(color: AppColors.textPrimaryDark),
      displaySmall: AppTypography.heading3
          .copyWith(color: AppColors.textPrimaryDark),
      bodyLarge: AppTypography.bodyLarge
          .copyWith(color: AppColors.textPrimaryDark),
      bodyMedium: AppTypography.bodyMedium
          .copyWith(color: AppColors.textPrimaryDark),
      bodySmall: AppTypography.bodySmall.copyWith(
          color: AppColors.textSecondaryDark),
      labelLarge: AppTypography.buttonLarge,
      labelMedium: AppTypography.label,
      labelSmall: AppTypography.caption,
    ),
  );

  // ─── Kids Theme ─────────────────────────────────────────
  static ThemeData kidsTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,

    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.kidsBlue,
      primary: AppColors.kidsBlue,
      secondary: AppColors.kidsGreen,
      tertiary: AppColors.kidsOrange,
    ),

    scaffoldBackgroundColor:
        const Color(0xFFFFF8E1),

    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: Colors.transparent,
      titleTextStyle:
          AppTypography.kidsHeading.copyWith(
        fontSize: 22,
        color: AppColors.kidsPurple,
      ),
    ),

    cardTheme: CardThemeData(
      elevation: 4,
      shadowColor:
          AppColors.kidsBlue.withOpacity(0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.kidsBlue,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 32,
          vertical: 20,
        ),
        textStyle: AppTypography.kidsButton,
        elevation: 4,
      ),
    ),

    textTheme: TextTheme(
      displayLarge: AppTypography.kidsHeading,
      displayMedium:
          AppTypography.kidsHeadingSmall,
      bodyLarge: AppTypography.kidsBody,
      bodyMedium: AppTypography.kidsBodySmall,
      labelLarge: AppTypography.kidsButton,
    ),
  );
}