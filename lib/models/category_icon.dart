import 'package:flutter/material.dart';

class CategoryIconData {
  final String id;
  final String label;
  final IconData icon;
  final Color? color;
  final String? description;
  final num? productCount;
  final bool isActive;

  const CategoryIconData({
    required this.id,
    required this.label,
    required this.icon,
    this.color,
    this.description,
    this.productCount,
    this.isActive = true,
  });
}
