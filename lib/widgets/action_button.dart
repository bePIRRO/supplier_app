import 'package:flutter/material.dart';
import '../design/design_system.dart';

/// Reusable action button widget for main action items
/// Based on the "Create Order" and "Invoices" buttons from the design
class ActionButton extends StatelessWidget {
  /// Button label/title
  final String title;

  /// Icon to display (optional)
  final IconData? icon;

  /// Callback when button is pressed
  final VoidCallback? onPressed;

  /// Button style variant
  final ActionButtonStyle style;

  /// Whether the button is enabled
  final bool enabled;

  /// Button width (defaults to flexible)
  final double? width;

  const ActionButton({
    super.key,
    required this.title,
    this.icon,
    this.onPressed,
    this.style = ActionButtonStyle.primary,
    this.enabled = true,
    this.width,
  });

  /// Primary action button (like "Create Order")
  const ActionButton.primary({
    super.key,
    required this.title,
    this.icon,
    this.onPressed,
    this.enabled = true,
    this.width,
  }) : style = ActionButtonStyle.primary;

  /// Secondary action button (like "Invoices")
  const ActionButton.secondary({
    super.key,
    required this.title,
    this.icon,
    this.onPressed,
    this.enabled = true,
    this.width,
  }) : style = ActionButtonStyle.secondary;

  /// Outlined action button
  const ActionButton.outlined({
    super.key,
    required this.title,
    this.icon,
    this.onPressed,
    this.enabled = true,
    this.width,
  }) : style = ActionButtonStyle.outlined;

  @override
  Widget build(BuildContext context) {
    final buttonStyle = _getButtonStyle();

    Widget child = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (icon != null) ...[
          Icon(icon, size: AppSizes.iconMd),
          const SizedBox(width: AppSpacing.spaceSm),
        ],
        Text(title),
      ],
    );

    return SizedBox(
      width: width,
      height: AppSizes.buttonHeightMd,
      child: ElevatedButton(
        onPressed: enabled ? onPressed : null,
        style: buttonStyle,
        child: child,
      ),
    );
  }

  ButtonStyle _getButtonStyle() {
    switch (style) {
      case ActionButtonStyle.primary:
        return AppButtonStyles.primaryButton;
      case ActionButtonStyle.secondary:
        return AppButtonStyles.secondaryButton;
      case ActionButtonStyle.outlined:
        return AppButtonStyles.outlinedButton;
    }
  }
}

/// Compact action button for smaller spaces
class CompactActionButton extends StatelessWidget {
  final String title;
  final IconData? icon;
  final VoidCallback? onPressed;
  final ActionButtonStyle style;
  final bool enabled;

  const CompactActionButton({
    super.key,
    required this.title,
    this.icon,
    this.onPressed,
    this.style = ActionButtonStyle.primary,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSizes.buttonHeightSm,
      child: ElevatedButton(
        onPressed: enabled ? onPressed : null,
        style: _getButtonStyle().copyWith(
          padding: WidgetStateProperty.all(
            const EdgeInsets.symmetric(
              horizontal: AppSpacing.paddingMd,
              vertical: AppSpacing.paddingSm,
            ),
          ),
          textStyle: WidgetStateProperty.all(AppTypography.buttonSmall),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: AppSizes.iconSm),
              const SizedBox(width: AppSpacing.spaceXs),
            ],
            Text(title),
          ],
        ),
      ),
    );
  }

  ButtonStyle _getButtonStyle() {
    switch (style) {
      case ActionButtonStyle.primary:
        return AppButtonStyles.primaryButton;
      case ActionButtonStyle.secondary:
        return AppButtonStyles.secondaryButton;
      case ActionButtonStyle.outlined:
        return AppButtonStyles.outlinedButton;
    }
  }
}

/// Grid of action buttons for dashboard layouts
class ActionButtonGrid extends StatelessWidget {
  final List<ActionButtonData> actions;
  final int crossAxisCount;
  final double? childAspectRatio;
  final EdgeInsets? padding;

  const ActionButtonGrid({
    super.key,
    required this.actions,
    this.crossAxisCount = 2,
    this.childAspectRatio = 2.5,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.all(AppSpacing.screenPadding),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          childAspectRatio: childAspectRatio ?? 2.5,
          crossAxisSpacing: AppSpacing.spaceMd,
          mainAxisSpacing: AppSpacing.spaceMd,
        ),
        itemCount: actions.length,
        itemBuilder: (context, index) {
          final action = actions[index];
          return ActionButton(
            title: action.title,
            icon: action.icon,
            onPressed: action.onPressed,
            style: action.style,
          );
        },
      ),
    );
  }
}

/// Horizontal list of action buttons
class ActionButtonList extends StatelessWidget {
  final List<ActionButtonData> actions;
  final EdgeInsets? padding;
  final double? buttonWidth;

  const ActionButtonList({
    super.key,
    required this.actions,
    this.padding,
    this.buttonWidth,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSizes.buttonHeightMd + (AppSpacing.spaceMd * 2),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding:
            padding ??
            const EdgeInsets.symmetric(
              horizontal: AppSpacing.screenPadding,
              vertical: AppSpacing.spaceMd,
            ),
        itemCount: actions.length,
        separatorBuilder: (context, index) =>
            const SizedBox(width: AppSpacing.spaceMd),
        itemBuilder: (context, index) {
          final action = actions[index];
          return ActionButton(
            title: action.title,
            icon: action.icon,
            onPressed: action.onPressed,
            style: action.style,
            width: buttonWidth ?? 140,
          );
        },
      ),
    );
  }
}

/// Action button style enumeration
enum ActionButtonStyle {
  primary, // Orange background
  secondary, // Dark background
  outlined, // Orange border
}

/// Data class for action button information
class ActionButtonData {
  final String title;
  final IconData? icon;
  final VoidCallback? onPressed;
  final ActionButtonStyle style;

  const ActionButtonData({
    required this.title,
    this.icon,
    this.onPressed,
    this.style = ActionButtonStyle.primary,
  });
}

/// Predefined action buttons for common app actions
class CommonActions {
  static const ActionButtonData createOrder = ActionButtonData(
    title: 'Create Order',
    icon: Icons.add_shopping_cart_outlined,
    style: ActionButtonStyle.primary,
  );

  static const ActionButtonData invoices = ActionButtonData(
    title: 'Invoices',
    icon: Icons.receipt_long_outlined,
    style: ActionButtonStyle.secondary,
  );

  static const ActionButtonData inventory = ActionButtonData(
    title: 'Inventory',
    icon: Icons.inventory_2_outlined,
    style: ActionButtonStyle.outlined,
  );

  static const ActionButtonData reports = ActionButtonData(
    title: 'Reports',
    icon: Icons.analytics_outlined,
    style: ActionButtonStyle.outlined,
  );

  static const ActionButtonData settings = ActionButtonData(
    title: 'Settings',
    icon: Icons.settings_outlined,
    style: ActionButtonStyle.outlined,
  );

  static const ActionButtonData support = ActionButtonData(
    title: 'Support',
    icon: Icons.help_outline,
    style: ActionButtonStyle.outlined,
  );
}

/// Quick action buttons for the home screen
class HomeScreenActions {
  static List<ActionButtonData> get main => [
    CommonActions.createOrder,
    CommonActions.invoices,
  ];

  static List<ActionButtonData> get secondary => [
    CommonActions.inventory,
    CommonActions.reports,
  ];
}
