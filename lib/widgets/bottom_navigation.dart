import 'package:flutter/material.dart';
import '../design/design_system.dart';

/// Custom bottom navigation bar widget for the app
/// Based on the home navigation design with Home, Orders, Cart, Profile
class AppBottomNavigation extends StatelessWidget {
  /// Currently selected tab index
  final int currentIndex;

  /// Callback when tab is selected
  final Function(int)? onTap;

  /// List of navigation items
  final List<AppBottomNavItem> items;

  /// Background color of the navigation bar
  final Color? backgroundColor;

  /// Whether to show labels
  final bool showLabels;

  const AppBottomNavigation({
    super.key,
    required this.currentIndex,
    this.onTap,
    required this.items,
    this.backgroundColor,
    this.showLabels = true,
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
          children: items.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;
            final isSelected = index == currentIndex;

            return _NavBarItem(
              item: item,
              isSelected: isSelected,
              showLabel: showLabels,
              onTap: () => onTap?.call(index),
            );
          }).toList(),
        ),
      ),
    );
  }
}

/// Individual navigation bar item widget
class _NavBarItem extends StatelessWidget {
  final AppBottomNavItem item;
  final bool isSelected;
  final bool showLabel;
  final VoidCallback? onTap;

  const _NavBarItem({
    required this.item,
    required this.isSelected,
    required this.showLabel,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = isSelected ? AppColors.primary : AppColors.textSecondary;
    final iconSize = isSelected
        ? AppSizes.navIconSelectedSize
        : AppSizes.navIconSize;

    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.radiusMd),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.paddingSm),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon with badge
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

              if (showLabel) ...[
                const SizedBox(height: 2),
                Text(
                  item.label,
                  style: AppTypography.navigationLabel.copyWith(
                    color: color,
                    fontWeight: isSelected
                        ? FontWeight.w600
                        : FontWeight.normal,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ],
          ),
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

/// Bottom navigation item data class
class AppBottomNavItem {
  final String label;
  final IconData icon;
  final int? badgeCount;

  const AppBottomNavItem({
    required this.label,
    required this.icon,
    this.badgeCount,
  });
}

/// Predefined navigation items for the supplier app
class SupplierNavItems {
  static const AppBottomNavItem home = AppBottomNavItem(
    label: 'Home',
    icon: Icons.home_outlined,
  );

  static const AppBottomNavItem orders = AppBottomNavItem(
    label: 'Orders',
    icon: Icons.shopping_bag_outlined,
  );

  static const AppBottomNavItem cart = AppBottomNavItem(
    label: 'Cart',
    icon: Icons.shopping_cart_outlined,
  );

  static const AppBottomNavItem profile = AppBottomNavItem(
    label: 'Profile',
    icon: Icons.person_outlined,
  );

  static List<AppBottomNavItem> get main => [home, orders, cart, profile];

  /// Navigation items with badge counts
  static List<AppBottomNavItem> withBadges({
    int? ordersBadge,
    int? cartBadge,
  }) => [
    home,
    AppBottomNavItem(
      label: 'Orders',
      icon: Icons.shopping_bag_outlined,
      badgeCount: ordersBadge,
    ),
    AppBottomNavItem(
      label: 'Cart',
      icon: Icons.shopping_cart_outlined,
      badgeCount: cartBadge,
    ),
    profile,
  ];
}

/// Alternative navigation layouts
class AlternativeNavLayouts {
  /// Minimal navigation with only essential items
  static List<AppBottomNavItem> get minimal => [
    SupplierNavItems.home,
    SupplierNavItems.orders,
    SupplierNavItems.profile,
  ];

  /// Extended navigation with additional items
  static List<AppBottomNavItem> get extended => [
    SupplierNavItems.home,
    const AppBottomNavItem(label: 'Products', icon: Icons.inventory_2_outlined),
    SupplierNavItems.orders,
    SupplierNavItems.cart,
    SupplierNavItems.profile,
  ];
}

/// Floating action button navigation variant
class FloatingBottomNavigation extends StatelessWidget {
  final int currentIndex;
  final Function(int)? onTap;
  final List<AppBottomNavItem> items;
  final VoidCallback? onFabPressed;
  final IconData? fabIcon;

  const FloatingBottomNavigation({
    super.key,
    required this.currentIndex,
    this.onTap,
    required this.items,
    this.onFabPressed,
    this.fabIcon = Icons.add,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        // Bottom navigation bar with gap
        AppBottomNavigation(
          currentIndex: currentIndex,
          onTap: onTap,
          items: items,
        ),

        // Floating action button
        Positioned(
          top: -28,
          child: FloatingActionButton(
            onPressed: onFabPressed,
            backgroundColor: AppColors.primary,
            child: Icon(fabIcon, color: AppColors.white),
          ),
        ),
      ],
    );
  }
}
