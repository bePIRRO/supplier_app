import 'package:flutter/material.dart';
import '../enums/app_screens.dart';
import '../widgets/menu/menu_style.dart' as menu;

class MenuType {
  final String name;
  final IconData icon;
  final AppScreens screen;
  final int? badgeCount;
  final bool enabled;

  const MenuType({
    required this.name,
    required this.icon,
    required this.screen,
    this.badgeCount,
    this.enabled = true,
  });

  /// Create MenuWidget from MenuItem
  menu.MenuWidget toWidget({
    Function(AppScreens)? onTap,
    bool isSelected = false,
    menu.MenuStyle style = menu.MenuStyle.list,
    bool showTrailing = true,
  }) {
    return menu.MenuWidget(
      name: name,
      icon: icon,
      screen: screen,
      onTap: onTap,
      isSelected: isSelected,
      menu: style,
      showTrailing: showTrailing,
      badgeCount: badgeCount,
      enabled: enabled,
    );
  }
}
