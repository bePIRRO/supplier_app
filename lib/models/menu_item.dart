import 'package:flutter/material.dart';
import 'package:supplier_app/enums/app_screens.dart';

class MenuItem {
  final String? name;
  final IconData? icon;
  final AppScreens? screen;
  final int? badgeCount;
  final bool? enabled;
  final String? description;

  const MenuItem({
    this.name,
    this.icon,
    this.screen,
    this.badgeCount,
    this.enabled,
    this.description,
  });
}
