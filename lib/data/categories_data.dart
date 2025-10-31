import 'package:flutter/material.dart';
import 'package:supplier_app/enums/category_type.dart';
import 'package:supplier_app/widgets/category_icon.dart';
import '../design/design_system.dart';

/// Mock category data for the Supplier App
class MockCategories {
  /// Main food categories
  static const List<CategoryIconData> foodCategories = [
    CategoryIconData(
      id: 'meat',
      label: 'Meat',
      icon: Icons.restaurant_outlined,
      color: AppColors.categoryMeat,
      description: 'Fresh meat and poultry',
      productCount: 8,
    ),
    CategoryIconData(
      id: 'vegetables',
      label: 'Vegetables',
      icon: Icons.eco_outlined,
      color: AppColors.categoryVegetables,
      description: 'Fresh vegetables and greens',
      productCount: 12,
    ),
    CategoryIconData(
      id: 'seafood',
      label: 'Seafood',
      icon: Icons.waves_outlined,
      color: AppColors.categorySeafood,
      description: 'Fresh fish and seafood',
      productCount: 6,
    ),
  ];

  /// Extended food categories
  static const List<CategoryIconData> allFoodCategories = [
    ...foodCategories,
    CategoryIconData(
      id: 'dairy',
      label: 'Dairy',
      icon: Icons.local_drink_outlined,
      color: AppColors.textSecondary,
      description: 'Milk, cheese, and dairy products',
      productCount: 15,
    ),
    CategoryIconData(
      id: 'fruits',
      label: 'Fruits',
      icon: Icons.apple_outlined,
      color: AppColors.primary,
      description: 'Fresh fruits and berries',
      productCount: 20,
    ),
    CategoryIconData(
      id: 'grains',
      label: 'Grains',
      icon: Icons.grain_outlined,
      color: AppColors.secondary,
      description: 'Rice, wheat, and grain products',
      productCount: 10,
    ),
    CategoryIconData(
      id: 'beverages',
      label: 'Beverages',
      icon: Icons.local_cafe_outlined,
      color: AppColors.categoryMeat,
      description: 'Drinks and beverages',
      productCount: 18,
    ),
    CategoryIconData(
      id: 'frozen',
      label: 'Frozen',
      icon: Icons.ac_unit_outlined,
      color: AppColors.categorySeafood,
      description: 'Frozen foods and products',
      productCount: 25,
    ),
    CategoryIconData(
      id: 'bakery',
      label: 'Bakery',
      icon: Icons.bakery_dining_outlined,
      color: AppColors.primary,
      description: 'Bread, pastries, and baked goods',
      productCount: 14,
    ),
  ];

  /// Business categories
  static const List<CategoryIconData> businessCategories = [
    CategoryIconData(
      id: 'restaurant',
      label: 'Restaurant',
      icon: Icons.restaurant_menu_outlined,
      color: AppColors.primary,
      description: 'Full-service restaurants',
      productCount: 45,
    ),
    CategoryIconData(
      id: 'cafe',
      label: 'Cafe',
      icon: Icons.local_cafe_outlined,
      color: AppColors.categoryVegetables,
      description: 'Coffee shops and cafes',
      productCount: 28,
    ),
    CategoryIconData(
      id: 'hotel',
      label: 'Hotel',
      icon: Icons.hotel_outlined,
      color: AppColors.categorySeafood,
      description: 'Hotels and hospitality',
      productCount: 62,
    ),
    CategoryIconData(
      id: 'catering',
      label: 'Catering',
      icon: Icons.event_outlined,
      color: AppColors.categoryMeat,
      description: 'Catering services',
      productCount: 33,
    ),
  ];

  /// Order status categories
  static const List<CategoryIconData> orderStatusCategories = [
    CategoryIconData(
      id: 'pending',
      label: 'Pending',
      icon: Icons.pending_outlined,
      color: AppColors.warning,
      description: 'Orders awaiting confirmation',
      productCount: 5,
    ),
    CategoryIconData(
      id: 'processing',
      label: 'Processing',
      icon: Icons.local_shipping_outlined,
      color: AppColors.info,
      description: 'Orders being prepared',
      productCount: 8,
    ),
    CategoryIconData(
      id: 'delivered',
      label: 'Delivered',
      icon: Icons.check_circle_outline,
      color: AppColors.success,
      description: 'Completed orders',
      productCount: 42,
    ),
    CategoryIconData(
      id: 'cancelled',
      label: 'Cancelled',
      icon: Icons.cancel_outlined,
      color: AppColors.error,
      description: 'Cancelled orders',
      productCount: 2,
    ),
  ];

  /// Get categories by type
  static List<CategoryIconData> getByType(CategoryType type) {
    switch (type) {
      case CategoryType.food:
        return foodCategories;
      case CategoryType.allFood:
        return allFoodCategories;
      case CategoryType.business:
        return businessCategories;
      case CategoryType.orderStatus:
        return orderStatusCategories;
    }
  }

  /// Get category by ID
  static CategoryIconData? getById(String id) {
    final allCategories = [
      ...allFoodCategories,
      ...businessCategories,
      ...orderStatusCategories,
    ];

    try {
      return allCategories.firstWhere((category) => category.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Search categories by name
  static List<CategoryIconData> search(String query, {CategoryType? type}) {
    List<CategoryIconData> searchList = type != null
        ? getByType(type)
        : allFoodCategories;

    if (query.isEmpty) return searchList;

    final lowercaseQuery = query.toLowerCase();
    return searchList
        .where(
          (category) =>
              category.label.toLowerCase().contains(lowercaseQuery) ||
              (category.description?.toLowerCase().contains(lowercaseQuery) ??
                  false),
        )
        .toList();
  }

  /// Get active categories only
  static List<CategoryIconData> getActive({CategoryType? type}) {
    List<CategoryIconData> sourceList = type != null
        ? getByType(type)
        : allFoodCategories;

    return sourceList.where((category) => category.isActive == true).toList();
  }

  /// Get categories with products
  static List<CategoryIconData> getWithProducts({CategoryType? type}) {
    List<CategoryIconData> sourceList = type != null
        ? getByType(type)
        : allFoodCategories;

    return sourceList
        .where(
          (category) =>
              category.productCount != null && category.productCount! > 0,
        )
        .toList();
  }

  /// Get total product count for a category type
  static num getTotalProductCount(CategoryType type) {
    return getByType(type)
        .where((category) => category.productCount != null)
        .fold(0, (sum, category) => sum + category.productCount!);
  }
}
