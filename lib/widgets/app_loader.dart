import 'package:flutter/material.dart';
import '../design/design_system.dart';

/// Reusable loading spinner component with primary orange color
/// Provides different sizes and variations for consistent loading states
class AppLoader extends StatelessWidget {
  /// Size of the loader
  final AppLoaderSize size;

  /// Color of the loader (defaults to primary orange)
  final Color? color;

  /// Stroke width of the spinner
  final double? strokeWidth;

  /// Whether to center the loader
  final bool center;

  const AppLoader({
    super.key,
    this.size = AppLoaderSize.medium,
    this.color,
    this.strokeWidth,
    this.center = false,
  });

  /// Small loader for buttons
  const AppLoader.small({
    super.key,
    this.color,
    this.strokeWidth,
    this.center = false,
  }) : size = AppLoaderSize.small;

  /// Medium loader for general use
  const AppLoader.medium({
    super.key,
    this.color,
    this.strokeWidth,
    this.center = true,
  }) : size = AppLoaderSize.medium;

  /// Large loader for full screen loading
  const AppLoader.large({
    super.key,
    this.color,
    this.strokeWidth,
    this.center = true,
  }) : size = AppLoaderSize.large;

  /// Button loader specifically for button loading states
  const AppLoader.button({
    super.key,
    this.color = AppColors.white,
    this.strokeWidth,
    this.center = false,
  }) : size = AppLoaderSize.button;

  @override
  Widget build(BuildContext context) {
    final loaderSize = _getLoaderSize();
    final loaderStrokeWidth = strokeWidth ?? _getStrokeWidth();
    final loaderColor = color ?? AppColors.primary;

    Widget loader = SizedBox(
      height: loaderSize,
      width: loaderSize,
      child: CircularProgressIndicator(
        strokeWidth: loaderStrokeWidth,
        valueColor: AlwaysStoppedAnimation<Color>(loaderColor),
      ),
    );

    // Center the loader if requested
    if (center) {
      loader = Center(child: loader);
    }

    return loader;
  }

  double _getLoaderSize() {
    switch (size) {
      case AppLoaderSize.small:
        return 16.0;
      case AppLoaderSize.button:
        return 20.0;
      case AppLoaderSize.medium:
        return 32.0;
      case AppLoaderSize.large:
        return 48.0;
    }
  }

  double _getStrokeWidth() {
    switch (size) {
      case AppLoaderSize.small:
        return 2.0;
      case AppLoaderSize.button:
        return 2.0;
      case AppLoaderSize.medium:
        return 3.0;
      case AppLoaderSize.large:
        return 4.0;
    }
  }
}

/// Overlay loader for full-screen loading states
class AppLoaderOverlay extends StatelessWidget {
  /// Whether the overlay is visible
  final bool isVisible;

  /// Child widget to display behind the overlay
  final Widget child;

  /// Background color of the overlay
  final Color? backgroundColor;

  const AppLoaderOverlay({
    super.key,
    required this.child,
    this.isVisible = false,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isVisible)
          Container(
            color: backgroundColor ?? AppColors.black.withOpacity(0.5),
            child: const AppLoader.large(color: AppColors.primary),
          ),
      ],
    );
  }
}

/// Loading dialog for modal loading states
class AppLoadingDialog {
  static void show(BuildContext context, {bool barrierDismissible = false}) {
    showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      barrierColor: AppColors.black.withOpacity(0.5),
      builder: (context) => WillPopScope(
        onWillPop: () async => barrierDismissible,
        child: Dialog(
          backgroundColor: AppColors.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.dialogRadius),
          ),
          child: const Padding(
            padding: EdgeInsets.all(AppSpacing.paddingXl),
            child: AppLoader.medium(),
          ),
        ),
      ),
    );
  }

  static void hide(BuildContext context) {
    Navigator.of(context).pop();
  }
}

/// Loader size enumeration
enum AppLoaderSize {
  small, // 16px - for small UI elements
  button, // 20px - for button loading states
  medium, // 32px - for general loading
  large, // 48px - for full screen loading
}

/// Pre-configured loader instances for common use cases
class AppLoaders {
  /// Small orange loader
  static const small = AppLoader.small();

  /// Medium orange loader (centered)
  static const medium = AppLoader.medium();

  /// Large orange loader (centered)
  static const large = AppLoader.large();

  /// White button loader (for primary buttons)
  static const button = AppLoader.button();
}
