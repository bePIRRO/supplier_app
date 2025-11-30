import 'package:flutter/material.dart' hide MenuStyle;
import '../../design/design_system.dart';
import '../../enums/app_screens.dart';
import '../../models/menu_type.dart';

/// Contains name, icon, and screen properties as requested
class MenuWidget extends StatelessWidget {
  /// Menu item name/label
  final String name;

  /// Icon to display
  final IconData icon;

  /// Target screen for navigation
  final AppScreens screen;

  /// Callback when menu item is tapped
  final Function(AppScreens)? onTap;

  /// Whether this menu item is selected/active
  final bool isSelected;

  /// Menu item style variant
  final MenuStyle menu;

  /// Whether to show trailing arrow
  final bool showTrailing;

  /// Badge count for notifications
  final int? badgeCount;

  /// Whether the menu item is enabled
  final bool enabled;

  const MenuWidget({
    super.key,
    required this.name,
    required this.icon,
    required this.screen,
    this.onTap,
    this.isSelected = false,
    this.menu = MenuStyle.list,
    this.showTrailing = true,
    this.badgeCount,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    switch (menu) {
      case MenuStyle.list:
        return _buildListItem();
      case MenuStyle.card:
        return _buildCardItem();
      case MenuStyle.tile:
        return _buildTileItem();
      case MenuStyle.compact:
        return _buildCompactItem();
    }
  }

  Widget _buildListItem() {
    return ListTile(
      enabled: enabled,
      selected: isSelected,
      leading: _buildIcon(),
      title: Text(name, style: _getTextStyle()),
      trailing: _buildTrailing(),
      onTap: enabled ? () => onTap?.call(screen) : null,
      selectedTileColor: AppColors.primary.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.radiusMd),
      ),
    );
  }

  Widget _buildCardItem() {
    return Card(
      elevation: isSelected ? AppElevation.md : AppElevation.sm,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.cardRadius),
        side: isSelected
            ? BorderSide(color: AppColors.primary, width: 2)
            : BorderSide.none,
      ),
      child: InkWell(
        onTap: enabled ? () => onTap?.call(screen) : null,
        borderRadius: BorderRadius.circular(AppRadius.cardRadius),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.paddingMd),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildIcon(),
              const SizedBox(height: AppSpacing.spaceSm),
              Text(
                name,
                style: _getTextStyle(),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTileItem() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primary.withOpacity(0.1) : null,
        borderRadius: BorderRadius.circular(AppRadius.radiusMd),
        border: isSelected
            ? Border.all(color: AppColors.primary.withOpacity(0.3))
            : null,
      ),
      child: ListTile(
        enabled: enabled,
        dense: true,
        leading: _buildIcon(),
        title: Text(name, style: _getTextStyle()),
        trailing: _buildTrailing(),
        onTap: enabled ? () => onTap?.call(screen) : null,
      ),
    );
  }

  Widget _buildCompactItem() {
    return InkWell(
      onTap: enabled ? () => onTap?.call(screen) : null,
      borderRadius: BorderRadius.circular(AppRadius.radiusMd),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.paddingMd,
          vertical: AppSpacing.paddingSm,
        ),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary.withOpacity(0.1) : null,
          borderRadius: BorderRadius.circular(AppRadius.radiusMd),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildIcon(),
            const SizedBox(width: AppSpacing.spaceSm),
            Text(name, style: _getTextStyle()),
            if (badgeCount != null && badgeCount! > 0) ...[
              const SizedBox(width: AppSpacing.spaceSm),
              _buildBadge(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildIcon() {
    Color iconColor = _getIconColor();

    Widget iconWidget = Icon(icon, size: _getIconSize(), color: iconColor);

    // Add badge if present
    if (badgeCount != null && badgeCount! > 0 && menu != MenuStyle.compact) {
      return Stack(
        clipBehavior: Clip.none,
        children: [
          iconWidget,
          Positioned(right: -6, top: -6, child: _buildBadge()),
        ],
      );
    }

    return iconWidget;
  }

  Widget? _buildTrailing() {
    if (!showTrailing) return null;

    return Icon(
      Icons.chevron_right,
      size: AppSizes.iconSm,
      color: enabled
          ? (isSelected ? AppColors.primary : AppColors.textSecondary)
          : AppColors.disabled,
    );
  }

  Widget _buildBadge() {
    return Container(
      constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
      decoration: BoxDecoration(
        color: AppColors.error,
        borderRadius: BorderRadius.circular(AppRadius.radiusFull),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      child: Text(
        badgeCount! > 99 ? '99+' : badgeCount.toString(),
        style: AppTypography.labelSmall.copyWith(
          color: AppColors.white,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Color _getIconColor() {
    if (!enabled) return AppColors.disabled;
    if (isSelected) return AppColors.primary;
    return AppColors.textSecondary;
  }

  TextStyle _getTextStyle() {
    TextStyle baseStyle = menu == MenuStyle.compact
        ? AppTypography.bodyMedium
        : AppTypography.bodyMedium;

    Color textColor = _getIconColor();
    FontWeight fontWeight = isSelected ? FontWeight.w600 : FontWeight.normal;

    return baseStyle.copyWith(color: textColor, fontWeight: fontWeight);
  }

  double _getIconSize() {
    switch (menu) {
      case MenuStyle.card:
        return AppSizes.iconLg;
      case MenuStyle.compact:
        return AppSizes.iconSm;
      case MenuStyle.list:
      case MenuStyle.tile:
        return AppSizes.iconMd;
    }
  }
}

enum MenuStyle {
  list, // Standard list item
  card, // Card layout with icon on top
  tile, // Dense tile layout
  compact, // Minimal horizontal layout
}

/// Menu list widget for displaying multiple menu items
class MenuList extends StatelessWidget {
  final List<MenuType> items;
  final AppScreens? selectedScreen;
  final Function(AppScreens)? onItemTap;
  final MenuStyle style;
  final bool showTrailing;
  final EdgeInsets? padding;
  final String? title;

  const MenuList({
    super.key,
    required this.items,
    this.selectedScreen,
    this.onItemTap,
    this.style = MenuStyle.list,
    this.showTrailing = true,
    this.padding,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.all(AppSpacing.screenPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            Text(title!, style: AppTypography.h6),
            const SizedBox(height: AppSpacing.spaceMd),
          ],
          ...items.map(
            (item) => item.toWidget(
              onTap: onItemTap,
              isSelected: selectedScreen == item.screen,
              style: style,
              showTrailing: showTrailing,
            ),
          ),
        ],
      ),
    );
  }
}

/// Grid menu widget for card-style layouts
class MenuGrid extends StatelessWidget {
  final List<MenuType> items;
  final AppScreens? selectedScreen;
  final Function(AppScreens)? onItemTap;
  final int crossAxisCount;
  final double? childAspectRatio;
  final EdgeInsets? padding;
  final String? title;

  const MenuGrid({
    super.key,
    required this.items,
    this.selectedScreen,
    this.onItemTap,
    this.crossAxisCount = 2,
    this.childAspectRatio = 1.2,
    this.padding,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.all(AppSpacing.screenPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            Text(title!, style: AppTypography.h6),
            const SizedBox(height: AppSpacing.spaceMd),
          ],
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              childAspectRatio: childAspectRatio ?? 1.2,
              crossAxisSpacing: AppSpacing.spaceMd,
              mainAxisSpacing: AppSpacing.spaceMd,
            ),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return item.toWidget(
                onTap: onItemTap,
                isSelected: selectedScreen == item.screen,
                style: MenuStyle.card,
                showTrailing: false,
              );
            },
          ),
        ],
      ),
    );
  }
}
