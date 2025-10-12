import 'package:flutter/material.dart';

class ProductData {
  final String id;
  final String name;
  final String? description;
  final String? imageUrl;
  final String? price;
  final Color? backgroundColor;
  final String? category;
  final bool isAvailable;
  final bool isFeatured;
  final int? stockQuantity;
  final String? unit; // kg, pieces, liters, etc.

  const ProductData({
    required this.id,
    required this.name,
    this.description,
    this.imageUrl,
    this.price,
    this.backgroundColor,
    this.category,
    this.isAvailable = true,
    this.isFeatured = false,
    this.stockQuantity,
    this.unit,
  });
}
