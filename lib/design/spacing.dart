/// Design system spacing and layout constants for the Supplier App
/// Based on the design specifications shown in the mockup
class AppSpacing {
  // Base spacing unit
  static const double baseUnit = 4.0;

  // Spacing scale based on design specs
  static const double spaceXs = 4.0; // Space-xs from design
  static const double spaceSm = 8.0; // Space-sm from design
  static const double spaceMd = 16.0; // Space-md from design
  static const double spaceLg = 24.0;
  static const double spaceXl = 32.0;
  static const double space2xl = 48.0;
  static const double space3xl = 64.0;

  // Padding variations
  static const double paddingXs = spaceXs;
  static const double paddingSm = spaceSm;
  static const double paddingMd = spaceMd;
  static const double paddingLg = spaceLg;
  static const double paddingXl = spaceXl;

  // Margin variations
  static const double marginXs = spaceXs;
  static const double marginSm = spaceSm;
  static const double marginMd = spaceMd;
  static const double marginLg = spaceLg;
  static const double marginXl = spaceXl;

  // Component specific spacing
  static const double buttonPaddingHorizontal = 24.0;
  static const double buttonPaddingVertical = 12.0;
  static const double inputPaddingHorizontal = 16.0;
  static const double inputPaddingVertical = 14.0;
  static const double cardPadding = 16.0;
  static const double sectionSpacing = 32.0;
  static const double itemSpacing = 16.0;

  // Layout spacing
  static const double screenPadding = 16.0;
  static const double contentSpacing = 24.0;
  static const double headerSpacing = 32.0;
  static const double footerSpacing = 24.0;
}

/// Border radius constants based on design specifications
class AppRadius {
  // Base radius values from design (V.pactes-m, Radius-md, Radius-lg)
  static const double radiusXs = 4.0;
  static const double radiusSm = 6.0;
  static const double radiusMd = 8.0; // Radius-md from design
  static const double radiusLg = 12.0; // Radius-lg from design
  static const double radiusXl = 16.0;
  static const double radius2xl = 24.0;
  static const double radiusFull = 9999.0;

  // Component specific radius
  static const double buttonRadius = radiusMd;
  static const double inputRadius = radiusMd;
  static const double cardRadius = radiusLg;
  static const double imageRadius = radiusMd;
  static const double avatarRadius = radiusFull;
  static const double chipRadius = radiusFull;

  // Special radius values
  static const double bottomSheetRadius = radiusXl;
  static const double dialogRadius = radiusLg;
  static const double snackBarRadius = radiusMd;
}

/// Size constants for consistent component sizing
class AppSizes {
  // Icon sizes
  static const double iconXs = 16.0;
  static const double iconSm = 20.0;
  static const double iconMd = 24.0;
  static const double iconLg = 32.0;
  static const double iconXl = 40.0;

  // Button sizes
  static const double buttonHeightSm = 32.0;
  static const double buttonHeightMd = 44.0;
  static const double buttonHeightLg = 52.0;
  static const double buttonMinWidth = 64.0;

  // Input field sizes
  static const double inputHeight = 48.0;
  static const double inputHeightSm = 40.0;
  static const double inputHeightLg = 56.0;

  // Avatar sizes
  static const double avatarXs = 24.0;
  static const double avatarSm = 32.0;
  static const double avatarMd = 40.0;
  static const double avatarLg = 56.0;
  static const double avatarXl = 80.0;

  // Card and container sizes
  static const double cardMinHeight = 120.0;
  static const double cardMaxWidth = 400.0;
  static const double containerMaxWidth = 1200.0;

  // App bar and navigation
  static const double appBarHeight = 56.0;
  static const double bottomNavHeight = 86.0;
  static const double tabBarHeight = 48.0;

  // Product card specific (from design)
  static const double productCardHeight = 160.0;
  static const double productImageHeight = 80.0;

  // Navigation icon sizes (from bottom nav in design)
  static const double navIconSize = 24.0;
  static const double navIconSelectedSize = 28.0;
}

/// Elevation constants for Material Design shadows
class AppElevation {
  static const double none = 0.0;
  static const double sm = 2.0;
  static const double md = 4.0;
  static const double lg = 8.0;
  static const double xl = 16.0;

  // Component specific elevations
  static const double cardElevation = md;
  static const double buttonElevation = sm;
  static const double appBarElevation = md;
  static const double bottomNavElevation = lg;
  static const double dialogElevation = xl;
  static const double drawerElevation = xl;
}

/// Animation duration constants
class AppDurations {
  static const Duration fast = Duration(milliseconds: 150);
  static const Duration normal = Duration(milliseconds: 300);
  static const Duration slow = Duration(milliseconds: 500);

  // Specific animations
  static const Duration buttonPress = fast;
  static const Duration pageTransition = normal;
  static const Duration fadeTransition = normal;
  static const Duration slideTransition = normal;
  static const Duration scaleTransition = fast;
}
