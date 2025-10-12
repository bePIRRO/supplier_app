import 'package:flutter/material.dart';
import 'colors.dart';
import 'spacing.dart';
import 'typography.dart';

/// UI component styles and themes for the Supplier App
/// Based on the design mockup components
class AppButtonStyles {
  // Primary button style (orange button from design)
  static ButtonStyle primaryButton = ElevatedButton.styleFrom(
    backgroundColor: AppColors.primary,
    foregroundColor: AppColors.textOnPrimary,
    elevation: AppElevation.buttonElevation,
    padding: const EdgeInsets.symmetric(
      horizontal: AppSpacing.buttonPaddingHorizontal,
      vertical: AppSpacing.buttonPaddingVertical,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppRadius.buttonRadius),
    ),
    textStyle: AppTypography.buttonMedium,
    minimumSize: const Size(AppSizes.buttonMinWidth, AppSizes.buttonHeightMd),
  );

  // Secondary button style
  static ButtonStyle secondaryButton = ElevatedButton.styleFrom(
    backgroundColor: AppColors.secondary,
    foregroundColor: AppColors.textOnSecondary,
    elevation: AppElevation.buttonElevation,
    padding: const EdgeInsets.symmetric(
      horizontal: AppSpacing.buttonPaddingHorizontal,
      vertical: AppSpacing.buttonPaddingVertical,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppRadius.buttonRadius),
    ),
    textStyle: AppTypography.buttonMedium,
    minimumSize: const Size(AppSizes.buttonMinWidth, AppSizes.buttonHeightMd),
  );

  // Outlined button style
  static ButtonStyle outlinedButton = OutlinedButton.styleFrom(
    foregroundColor: AppColors.primary,
    side: const BorderSide(color: AppColors.primary, width: 1.5),
    padding: const EdgeInsets.symmetric(
      horizontal: AppSpacing.buttonPaddingHorizontal,
      vertical: AppSpacing.buttonPaddingVertical,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppRadius.buttonRadius),
    ),
    textStyle: AppTypography.buttonMedium,
    minimumSize: const Size(AppSizes.buttonMinWidth, AppSizes.buttonHeightMd),
  );

  // Text button style (like "Sign up" link in design)
  static ButtonStyle textButton = TextButton.styleFrom(
    foregroundColor: AppColors.primary,
    padding: const EdgeInsets.symmetric(
      horizontal: AppSpacing.paddingMd,
      vertical: AppSpacing.paddingSm,
    ),
    textStyle: AppTypography.buttonMedium,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppRadius.buttonRadius),
    ),
  );

  // Small button variant
  static ButtonStyle primaryButtonSmall = primaryButton.copyWith(
    padding: MaterialStateProperty.all(
      const EdgeInsets.symmetric(
        horizontal: AppSpacing.paddingMd,
        vertical: AppSpacing.paddingSm,
      ),
    ),
    textStyle: MaterialStateProperty.all(AppTypography.buttonSmall),
    minimumSize: MaterialStateProperty.all(
      const Size(AppSizes.buttonMinWidth, AppSizes.buttonHeightSm),
    ),
  );

  // Large button variant
  static ButtonStyle primaryButtonLarge = primaryButton.copyWith(
    padding: MaterialStateProperty.all(
      const EdgeInsets.symmetric(
        horizontal: AppSpacing.paddingXl,
        vertical: AppSpacing.paddingMd,
      ),
    ),
    textStyle: MaterialStateProperty.all(AppTypography.buttonLarge),
    minimumSize: MaterialStateProperty.all(
      const Size(AppSizes.buttonMinWidth, AppSizes.buttonHeightLg),
    ),
  );

  // Add to order button style (from product card)
  static ButtonStyle addToOrderButton = ElevatedButton.styleFrom(
    backgroundColor: AppColors.white,
    foregroundColor: AppColors.textPrimary,
    elevation: 0,
    side: const BorderSide(color: AppColors.border, width: 1),
    padding: const EdgeInsets.symmetric(
      horizontal: AppSpacing.paddingMd,
      vertical: AppSpacing.paddingSm,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppRadius.buttonRadius),
    ),
    textStyle: AppTypography.buttonSmall,
  );
}

/// Card component styles
class AppCardStyles {
  // Product card style (from the tomatoes card in design)
  static BoxDecoration productCard = BoxDecoration(
    color: AppColors.surface,
    borderRadius: BorderRadius.circular(AppRadius.cardRadius),
    boxShadow: [
      BoxShadow(
        color: AppColors.shadow,
        blurRadius: AppElevation.cardElevation,
        offset: const Offset(0, 2),
      ),
    ],
  );

  // Basic card style
  static BoxDecoration basicCard = BoxDecoration(
    color: AppColors.surface,
    borderRadius: BorderRadius.circular(AppRadius.cardRadius),
    border: Border.all(color: AppColors.border, width: 1),
  );

  // Elevated card style
  static BoxDecoration elevatedCard = BoxDecoration(
    color: AppColors.surface,
    borderRadius: BorderRadius.circular(AppRadius.cardRadius),
    boxShadow: [
      BoxShadow(
        color: AppColors.shadow,
        blurRadius: AppElevation.cardElevation,
        offset: const Offset(0, 2),
      ),
    ],
  );

  // Featured card style (with primary color accent)
  static BoxDecoration featuredCard = BoxDecoration(
    color: AppColors.surface,
    borderRadius: BorderRadius.circular(AppRadius.cardRadius),
    border: Border.all(color: AppColors.primary, width: 2),
    boxShadow: [
      BoxShadow(
        color: AppColors.primary.withOpacity(0.1),
        blurRadius: AppElevation.cardElevation,
        offset: const Offset(0, 2),
      ),
    ],
  );
}

/// Input field styles
class AppInputStyles {
  // Primary input decoration
  static InputDecoration primaryInput = InputDecoration(
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
  );

  // Search input decoration
  static InputDecoration searchInput = primaryInput.copyWith(
    prefixIcon: const Icon(Icons.search, color: AppColors.textSecondary),
    hintText: 'Search...',
    filled: true,
    fillColor: AppColors.backgroundSecondary,
  );
}

/// Category icon styles (from bottom navigation)
class AppCategoryStyles {
  static BoxDecoration categoryIcon = BoxDecoration(
    color: AppColors.backgroundSecondary,
    borderRadius: BorderRadius.circular(AppRadius.radiusMd),
    border: Border.all(color: AppColors.border, width: 1),
  );

  static BoxDecoration categoryIconSelected = BoxDecoration(
    color: AppColors.primary.withOpacity(0.1),
    borderRadius: BorderRadius.circular(AppRadius.radiusMd),
    border: Border.all(color: AppColors.primary, width: 2),
  );
}

/// Navigation styles
class AppNavigationStyles {
  // Bottom navigation bar theme
  static BottomNavigationBarThemeData bottomNavTheme =
      BottomNavigationBarThemeData(
        backgroundColor: AppColors.surface,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textSecondary,
        selectedLabelStyle: AppTypography.navigationLabel,
        unselectedLabelStyle: AppTypography.navigationLabel,
        type: BottomNavigationBarType.fixed,
        elevation: AppElevation.bottomNavElevation,
      );

  // App bar theme
  static AppBarTheme appBarTheme = AppBarTheme(
    backgroundColor: AppColors.surface,
    foregroundColor: AppColors.textPrimary,
    elevation: AppElevation.appBarElevation,
    centerTitle: true,
    titleTextStyle: AppTypography.h6,
    iconTheme: const IconThemeData(color: AppColors.textPrimary),
  );
}

/// Chip styles
class AppChipStyles {
  static ChipThemeData chipTheme = ChipThemeData(
    backgroundColor: AppColors.backgroundSecondary,
    selectedColor: AppColors.primary.withOpacity(0.1),
    disabledColor: AppColors.disabled,
    labelStyle: AppTypography.labelMedium,
    secondaryLabelStyle: AppTypography.labelMedium,
    brightness: Brightness.light,
    padding: const EdgeInsets.symmetric(
      horizontal: AppSpacing.paddingSm,
      vertical: AppSpacing.paddingXs,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppRadius.chipRadius),
    ),
  );
}

/// Dialog styles
class AppDialogStyles {
  static ShapeDecoration dialogDecoration = ShapeDecoration(
    color: AppColors.surface,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppRadius.dialogRadius),
    ),
    shadows: [
      BoxShadow(
        color: AppColors.shadowDark,
        blurRadius: AppElevation.dialogElevation,
        offset: const Offset(0, 4),
      ),
    ],
  );
}

/// Divider styles
class AppDividerStyles {
  static Divider horizontalDivider = const Divider(
    color: AppColors.border,
    thickness: 1,
    height: 1,
  );

  static VerticalDivider verticalDivider = const VerticalDivider(
    color: AppColors.border,
    thickness: 1,
    width: 1,
  );
}

/// Loading indicator styles
class AppLoadingStyles {
  static Widget primaryLoader = const CircularProgressIndicator(
    valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
    strokeWidth: 3,
  );

  static Widget secondaryLoader = const CircularProgressIndicator(
    valueColor: AlwaysStoppedAnimation<Color>(AppColors.secondary),
    strokeWidth: 2,
  );
}
