import 'package:flutter/material.dart';
import '../enums/app_screens.dart';
import '../models/menu_type.dart';

/// Collection of predefined menu items using MenuType
class MenuTypesData {
  // Main navigation items
  static const MenuType home = MenuType(
    name: 'Home',
    icon: Icons.home_outlined,
    screen: AppScreens.home,
  );

  static const MenuType products = MenuType(
    name: 'Products',
    icon: Icons.inventory_2_outlined,
    screen: AppScreens.products,
  );

  static const MenuType orders = MenuType(
    name: 'Orders',
    icon: Icons.shopping_bag_outlined,
    screen: AppScreens.orders,
  );

  static const MenuType cart = MenuType(
    name: 'Cart',
    icon: Icons.shopping_cart_outlined,
    screen: AppScreens.cart,
  );

  static const MenuType profile = MenuType(
    name: 'Profile',
    icon: Icons.person_outlined,
    screen: AppScreens.profile,
  );

  // Action items
  static const MenuType createOrder = MenuType(
    name: 'Create Order',
    icon: Icons.add_shopping_cart_outlined,
    screen: AppScreens.createOrder,
  );

  static const MenuType invoices = MenuType(
    name: 'Invoices',
    icon: Icons.receipt_long_outlined,
    screen: AppScreens.invoices,
  );

  static const MenuType inventory = MenuType(
    name: 'Inventory',
    icon: Icons.warehouse_outlined,
    screen: AppScreens.inventory,
  );

  static const MenuType reports = MenuType(
    name: 'Reports',
    icon: Icons.analytics_outlined,
    screen: AppScreens.reports,
  );

  // Settings items
  static const MenuType settings = MenuType(
    name: 'Settings',
    icon: Icons.settings_outlined,
    screen: AppScreens.settings,
  );

  static const MenuType notifications = MenuType(
    name: 'Notifications',
    icon: Icons.notifications_outlined,
    screen: AppScreens.notifications,
  );

  static const MenuType support = MenuType(
    name: 'Support',
    icon: Icons.help_outline,
    screen: AppScreens.support,
  );

  // Grouped menu items
  static List<MenuType> get mainNavigation => [
    home,
    products,
    orders,
    cart,
    profile,
  ];

  static List<MenuType> get businessActions => [
    createOrder,
    invoices,
    inventory,
    reports,
  ];

  static List<MenuType> get settingsMenu => [settings, notifications, support];

  static List<MenuType> get allItems => [
    ...mainNavigation,
    ...businessActions,
    ...settingsMenu,
  ];
}
