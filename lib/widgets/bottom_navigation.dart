import 'package:flutter/material.dart';
import '../design/design_system.dart';
import '../models/menu_type.dart';
import '../enums/app_screens.dart';

/// Custom bottom navigation bar widget for the app
/// Based on MenuWidget for consistency
class AppBottomNavigation extends StatelessWidget {
  /// List of navigation menu items
  final List<MenuType> items;

  /// Currently selected screen
  final AppScreens selectedScreen;

  /// Callback when tab is selected
  final Function(AppScreens)? onTap;

  /// Background color of the navigation bar
  final Color? backgroundColor;

  const AppBottomNavigation({
    super.key,
    required this.items,
    required this.selectedScreen,
    this.onTap,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSizes.bottomNavHeight,
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: AppElevation.bottomNavElevation,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: items.map((item) {
            final isSelected = item.screen == selectedScreen;
            return Expanded(
              child: _NavBarItem(
                item: item,
                isSelected: isSelected,
                onTap: () => onTap?.call(item.screen),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

/// Individual navigation bar item widget
class _NavBarItem extends StatelessWidget {
  final MenuType item;
  final bool isSelected;
  final VoidCallback? onTap;

  const _NavBarItem({required this.item, required this.isSelected, this.onTap});

  @override
  Widget build(BuildContext context) {
    final color = isSelected ? AppColors.primary : AppColors.textSecondary;
    final iconSize = isSelected
        ? AppSizes.navIconSelectedSize
        : AppSizes.navIconSize;

    return InkWell(
      onTap: item.enabled ? onTap : null,
      borderRadius: BorderRadius.circular(AppRadius.radiusMd),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.paddingSm),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(item.icon, size: iconSize, color: color),
                if (item.badgeCount != null && item.badgeCount! > 0)
                  Positioned(
                    right: -6,
                    top: -6,
                    child: _Badge(count: item.badgeCount!),
                  ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              item.name,
              style: AppTypography.navigationLabel.copyWith(
                color: color,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

/// Badge widget for notification counts
class _Badge extends StatelessWidget {
  final int count;

  const _Badge({required this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
      decoration: BoxDecoration(
        color: AppColors.error,
        borderRadius: BorderRadius.circular(AppRadius.radiusFull),
      ),
      padding: const EdgeInsets.all(2),
      child: Center(
        child: Text(
          count > 99 ? '99+' : count.toString(),
          style: AppTypography.labelSmall.copyWith(
            color: AppColors.white,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
