import 'package:flutter/material.dart';

/// Design system colors for the Supplier App
/// Based on the design mockup with primary orange and secondary dark colors
class AppColors {
  // Primary colors
  static const Color primary = Color(0xFFFF6B00); // Orange from design
  static const Color primaryLight = Color(0xFFFF8533);
  static const Color primaryDark = Color(0xFFE55A00);

  // Secondary colors
  static const Color secondary = Color(0xFF202DD7); // Dark blue from design
  static const Color secondaryLight = Color(0xFF4A56E0);
  static const Color secondaryDark = Color(0xFF1A25B8);

  // Neutral colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color grey900 = Color(0xFF1A1A1A);
  static const Color grey800 = Color(0xFF333333);
  static const Color grey700 = Color(0xFF4D4D4D);
  static const Color grey600 = Color(0xFF666666);
  static const Color grey500 = Color(0xFF808080);
  static const Color grey400 = Color(0xFF999999);
  static const Color grey300 = Color(0xFFB3B3B3);
  static const Color grey200 = Color(0xFFCCCCCC);
  static const Color grey100 = Color(0xFFE6E6E6);
  static const Color grey50 = Color(0xFFF5F5F5);

  // Background colors
  static const Color background = Color(0xFFFFFFFF);
  static const Color backgroundSecondary = Color(0xFFF8F9FA);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF5F5F5);

  // Text colors
  static const Color textPrimary = Color(0xFF1A1A1A);
  static const Color textSecondary = Color(0xFF666666);
  static const Color textTertiary = Color(0xFF999999);
  static const Color textOnPrimary = Color(0xFFFFFFFF);
  static const Color textOnSecondary = Color(0xFFFFFFFF);

  // Status colors
  static const Color success = Color(0xFF28A745);
  static const Color warning = Color(0xFFFFC107);
  static const Color error = Color(0xFFDC3545);
  static const Color info = Color(0xFF17A2B8);

  // Border colors
  static const Color border = Color(0xFFE6E6E6);
  static const Color borderSecondary = Color(0xFFCCCCCC);
  static const Color borderFocus = Color(0xFFFF6B00);

  // Category colors (from the bottom navigation icons)
  static const Color categoryMeat = Color(0xFF8B4513);
  static const Color categoryVegetables = Color(0xFF228B22);
  static const Color categorySeafood = Color(0xFF4682B4);

  // Disabled states
  static const Color disabled = Color(0xFFCCCCCC);
  static const Color disabledText = Color(0xFF999999);

  // Shadow colors
  static const Color shadow = Color(0x1A000000);
  static const Color shadowLight = Color(0x0D000000);
  static const Color shadowDark = Color(0x33000000);
}

/// Color palette for different themes
class AppColorScheme {
  static const ColorScheme lightScheme = ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.primary,
    onPrimary: AppColors.textOnPrimary,
    secondary: AppColors.secondary,
    onSecondary: AppColors.textOnSecondary,
    error: AppColors.error,
    onError: AppColors.white,
    background: AppColors.background,
    onBackground: AppColors.textPrimary,
    surface: AppColors.surface,
    onSurface: AppColors.textPrimary,
  );

  static const ColorScheme darkScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: AppColors.primary,
    onPrimary: AppColors.textOnPrimary,
    secondary: AppColors.secondary,
    onSecondary: AppColors.textOnSecondary,
    error: AppColors.error,
    onError: AppColors.white,
    background: AppColors.grey900,
    onBackground: AppColors.white,
    surface: AppColors.grey800,
    onSurface: AppColors.white,
  );
}
