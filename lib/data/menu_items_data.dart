import 'package:flutter/material.dart';
import 'package:supplier_app/enums/menu_category.dart';
import 'package:supplier_app/models/menu_item.dart';
import '../enums/app_screens.dart';

/// menu data for the Supplier App
class MenuItems {
  // Main navigation items
  static const MenuItem home = MenuItem(
    name: 'Home',
    icon: Icons.home_outlined,
    screen: AppScreens.home,
    description: 'Dashboard and overview',
  );

  static const MenuItem products = MenuItem(
    name: 'Products',
    icon: Icons.inventory_2_outlined,
    screen: AppScreens.products,
    description: 'Browse and manage products',
  );

  static const MenuItem orders = MenuItem(
    name: 'Orders',
    icon: Icons.shopping_bag_outlined,
    screen: AppScreens.orders,
    badgeCount: 3,
    description: 'View and manage orders',
  );

  static const MenuItem cart = MenuItem(
    name: 'Cart',
    icon: Icons.shopping_cart_outlined,
    screen: AppScreens.cart,
    badgeCount: 2,
    description: 'Shopping cart items',
  );

  static const MenuItem profile = MenuItem(
    name: 'Profile',
    icon: Icons.person_outlined,
    screen: AppScreens.profile,
    description: 'Account and settings',
  );

  // Action items
  static const MenuItem createOrder = MenuItem(
    name: 'Create Order',
    icon: Icons.add_shopping_cart_outlined,
    screen: AppScreens.createOrder,
    description: 'Start a new order',
  );

  static const MenuItem invoices = MenuItem(
    name: 'Invoices',
    icon: Icons.receipt_long_outlined,
    screen: AppScreens.invoices,
    description: 'View billing and invoices',
  );

  static const MenuItem inventory = MenuItem(
    name: 'Inventory',
    icon: Icons.warehouse_outlined,
    screen: AppScreens.inventory,
    description: 'Manage stock levels',
  );

  static const MenuItem reports = MenuItem(
    name: 'Reports',
    icon: Icons.analytics_outlined,
    screen: AppScreens.reports,
    description: 'Analytics and insights',
  );

  // Settings and support items
  static const MenuItem settings = MenuItem(
    name: 'Settings',
    icon: Icons.settings_outlined,
    screen: AppScreens.settings,
    description: 'App preferences',
  );

  static const MenuItem notifications = MenuItem(
    name: 'Notifications',
    icon: Icons.notifications_outlined,
    screen: AppScreens.notifications,
    badgeCount: 5,
    description: 'View notifications',
  );

  static const MenuItem support = MenuItem(
    name: 'Support',
    icon: Icons.help_outline,
    screen: AppScreens.support,
    description: 'Help and contact',
  );

  static const MenuItem dashboard = MenuItem(
    name: 'Dashboard',
    icon: Icons.dashboard_outlined,
    screen: AppScreens.dashboard,
    description: 'Business overview',
  );

  static const MenuItem customers = MenuItem(
    name: 'Customers',
    icon: Icons.people_outline,
    screen: AppScreens.customers,
    description: 'Customer management',
  );

  static const MenuItem suppliers = MenuItem(
    name: 'Suppliers',
    icon: Icons.business_outlined,
    screen: AppScreens.suppliers,
    description: 'Supplier network',
  );

  static const MenuItem analytics = MenuItem(
    name: 'Analytics',
    icon: Icons.trending_up_outlined,
    screen: AppScreens.analytics,
    description: 'Performance metrics',
  );

  // Grouped menu items
  static List<MenuItem> get mainNavigation => [
    home,
    products,
    orders,
    cart,
    profile,
  ];

  static List<MenuItem> get businessActions => [
    createOrder,
    invoices,
    inventory,
    reports,
  ];

  static List<MenuItem> get businessManagement => [
    dashboard,
    analytics,
    customers,
    suppliers,
  ];

  static List<MenuItem> get settingsMenu => [settings, notifications, support];

  static List<MenuItem> get quickActions => [createOrder, invoices];

  static List<MenuItem> get adminMenu => [
    dashboard,
    analytics,
    inventory,
    customers,
    suppliers,
    reports,
    settings,
  ];

  static List<MenuItem> get allItems => [
    ...mainNavigation,
    ...businessActions,
    ...businessManagement,
    ...settingsMenu,
  ];

  /// Get menu items by category
  static List<MenuItem> getByCategory(MenuCategory category) {
    switch (category) {
      case MenuCategory.navigation:
        return mainNavigation;
      case MenuCategory.business:
        return businessActions;
      case MenuCategory.management:
        return businessManagement;
      case MenuCategory.settings:
        return settingsMenu;
      case MenuCategory.quick:
        return quickActions;
      case MenuCategory.admin:
        return adminMenu;
    }
  }

  /// Search menu items by name
  static List<MenuItem> search(String query) {
    if (query.isEmpty) return allItems;

    final lowercaseQuery = query.toLowerCase();
    return allItems
        .where(
          (item) =>
              item.name!.toLowerCase().contains(lowercaseQuery) ||
              (item.description?.toLowerCase().contains(lowercaseQuery) ??
                  false),
        )
        .toList();
  }

  /// Get menu item by screen
  static MenuItem? getByScreen(AppScreens screen) {
    try {
      return allItems.firstWhere((item) => item.screen == screen);
    } catch (e) {
      return null;
    }
  }

  /// Get menu items with badges
  static List<MenuItem> get withBadges {
    return allItems
        .where((item) => item.badgeCount != null && item.badgeCount! > 0)
        .toList();
  }

  /// Get enabled menu items only
  static List<MenuItem> get enabled {
    return allItems.where((item) => item.enabled ?? true).toList();
  }
}
