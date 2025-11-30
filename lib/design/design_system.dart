/// Main design system export file for the Supplier App
/// This file provides a single import point for all design tokens and styles
///
/// Usage:
/// ```dart
/// import 'package:supplier_app/design/design_system.dart';
///
/// // Use design tokens
/// Container(
///   padding: EdgeInsets.all(AppSpacing.paddingMd),
///   decoration: AppCardStyles.productCard,
///   child: Text(
///     'Product Name',
///     style: AppTypography.productTitle,
///   ),
/// )
/// ```
library;

// Export all design system files
export 'colors.dart';
export 'spacing.dart';
export 'typography.dart';
export 'ui_components.dart';
export '../widgets/app_loader.dart';

import 'package:flutter/material.dart';
import 'colors.dart';
import 'spacing.dart';
import 'typography.dart';
import 'ui_components.dart';
import '../widgets/app_loader.dart';

/// Complete app theme based on the design system
class AppTheme {
  static ThemeData get lightTheme => ThemeData(
    useMaterial3: true,
    colorScheme: AppColorScheme.lightScheme,
    textTheme: AppTextTheme.textTheme,

    // App Bar Theme
    appBarTheme: AppNavigationStyles.appBarTheme,

    // Bottom Navigation Theme
    bottomNavigationBarTheme: AppNavigationStyles.bottomNavTheme,

    // Button Themes
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: AppButtonStyles.primaryButton,
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: AppButtonStyles.outlinedButton,
    ),
    textButtonTheme: TextButtonThemeData(style: AppButtonStyles.textButton),

    // Input Decoration Theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.surface,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.inputPaddingHorizontal,
        vertical: AppSpacing.inputPaddingVertical,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.inputRadius),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.inputRadius),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.inputRadius),
        borderSide: const BorderSide(color: AppColors.borderFocus, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.inputRadius),
        borderSide: const BorderSide(color: AppColors.error),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.inputRadius),
        borderSide: const BorderSide(color: AppColors.error, width: 2),
      ),
      hintStyle: AppTypography.inputHint,
      labelStyle: AppTypography.inputLabel,
      errorStyle: AppTypography.errorText,
    ),

    // Chip Theme
    chipTheme: AppChipStyles.chipTheme,

    // Card Theme
    cardTheme: CardThemeData(
      elevation: AppElevation.cardElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.cardRadius),
      ),
      color: AppColors.surface,
    ),

    // Divider Theme
    dividerTheme: const DividerThemeData(color: AppColors.border, thickness: 1),

    // Icon Theme
    iconTheme: const IconThemeData(
      color: AppColors.textSecondary,
      size: AppSizes.iconMd,
    ),

    // Primary Icon Theme (for app bars, etc.)
    primaryIconTheme: const IconThemeData(
      color: AppColors.textPrimary,
      size: AppSizes.iconMd,
    ),

    // Floating Action Button Theme
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.textOnPrimary,
      elevation: AppElevation.md,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.radiusFull),
      ),
    ),

    // Dialog Theme
    dialogTheme: DialogThemeData(
      backgroundColor: AppColors.surface,
      elevation: AppElevation.dialogElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.dialogRadius),
      ),
      titleTextStyle: AppTypography.h5,
      contentTextStyle: AppTypography.bodyMedium,
    ),

    // Snackbar Theme
    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColors.grey800,
      contentTextStyle: AppTypography.bodyMedium.copyWith(
        color: AppColors.white,
      ),
      actionTextColor: AppColors.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.snackBarRadius),
      ),
      behavior: SnackBarBehavior.floating,
    ),

    // Tab Bar Theme
    tabBarTheme: TabBarThemeData(
      labelColor: AppColors.primary,
      unselectedLabelColor: AppColors.textSecondary,
      labelStyle: AppTypography.labelLarge,
      unselectedLabelStyle: AppTypography.labelLarge,
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(color: AppColors.primary, width: 2),
      ),
    ),

    // Switch Theme
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.primary;
        }
        return AppColors.grey400;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.primary.withOpacity(0.3);
        }
        return AppColors.grey300;
      }),
    ),

    // Checkbox Theme
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.primary;
        }
        return AppColors.grey300;
      }),
      checkColor: WidgetStateProperty.all(AppColors.white),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.radiusXs),
      ),
    ),

    // Radio Theme
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.primary;
        }
        return AppColors.grey400;
      }),
    ),

    // Slider Theme
    sliderTheme: SliderThemeData(
      activeTrackColor: AppColors.primary,
      inactiveTrackColor: AppColors.grey300,
      thumbColor: AppColors.primary,
      overlayColor: AppColors.primary.withOpacity(0.1),
      valueIndicatorColor: AppColors.primary,
      valueIndicatorTextStyle: AppTypography.labelSmall.copyWith(
        color: AppColors.white,
      ),
    ),

    // Progress Indicator Theme
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.primary,
      linearTrackColor: AppColors.grey200,
      circularTrackColor: AppColors.grey200,
    ),
  );

  static ThemeData get darkTheme => lightTheme.copyWith(
    colorScheme: AppColorScheme.darkScheme,
    scaffoldBackgroundColor: AppColors.grey900,
    // Add other dark theme customizations as needed
  );
}

/// Design system constants for quick access
class DesignSystem {
  // Colors
  static const colors = AppColors;

  // Spacing
  static const spacing = AppSpacing;
  static const radius = AppRadius;
  static const sizes = AppSizes;
  static const elevation = AppElevation;
  static const durations = AppDurations;

  // Typography
  static const typography = AppTypography;

  // Component Styles
  static const buttons = AppButtonStyles;
  static const cards = AppCardStyles;
  static const inputs = AppInputStyles;
  static const navigation = AppNavigationStyles;
  static const chips = AppChipStyles;
  static const dialogs = AppDialogStyles;
  static const dividers = AppDividerStyles;
  static const loading = AppLoadingStyles;
  static const categories = AppCategoryStyles;

  // Loaders
  static const loaders = AppLoaders;
}
