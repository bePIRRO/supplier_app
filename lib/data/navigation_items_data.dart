import 'package:flutter/material.dart';
import '../models/menu_type.dart';
import '../enums/app_screens.dart';

/// Navigation items data for bottom navigation
class NavigationItemsData {
  /// Main navigation items
  static const List<MenuType> mainNavItems = [
    MenuType(name: 'Home', icon: Icons.home_outlined, screen: AppScreens.home),
    MenuType(
      name: 'Orders',
      icon: Icons.shopping_bag_outlined,
      screen: AppScreens.orders,
    ),
    MenuType(
      name: 'Cart',
      icon: Icons.shopping_cart_outlined,
      screen: AppScreens.cart,
    ),
    MenuType(
      name: 'Profile',
      icon: Icons.person_outlined,
      screen: AppScreens.profile,
    ),
  ];

  /// Get navigation items with custom badge counts
  static List<MenuType> withBadges({int? ordersBadge, int? cartBadge}) {
    return [
      const MenuType(
        name: 'Home',
        icon: Icons.home_outlined,
        screen: AppScreens.home,
      ),
      MenuType(
        name: 'Orders',
        icon: Icons.shopping_bag_outlined,
        screen: AppScreens.orders,
        badgeCount: ordersBadge,
      ),
      MenuType(
        name: 'Cart',
        icon: Icons.shopping_cart_outlined,
        screen: AppScreens.cart,
        badgeCount: cartBadge,
      ),
      const MenuType(
        name: 'Profile',
        icon: Icons.person_outlined,
        screen: AppScreens.profile,
      ),
    ];
  }
}
