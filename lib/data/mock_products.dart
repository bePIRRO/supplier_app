import 'package:flutter/material.dart';
import '../design/design_system.dart';

/// Product data model for the Supplier App
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

  /// Create a copy with modified properties
  ProductData copyWith({
    String? id,
    String? name,
    String? description,
    String? imageUrl,
    String? price,
    Color? backgroundColor,
    String? category,
    bool? isAvailable,
    bool? isFeatured,
    int? stockQuantity,
    String? unit,
  }) {
    return ProductData(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      price: price ?? this.price,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      category: category ?? this.category,
      isAvailable: isAvailable ?? this.isAvailable,
      isFeatured: isFeatured ?? this.isFeatured,
      stockQuantity: stockQuantity ?? this.stockQuantity,
      unit: unit ?? this.unit,
    );
  }
}

/// Mock product data for the Supplier App
class MockProducts {
  /// Featured products for the home screen
  static const List<ProductData> featured = [
    ProductData(
      id: 'prod_001',
      name: 'Tomatoes',
      description: 'Fresh organic tomatoes',
      price: '\$4.99/kg',
      unit: 'kg',
      backgroundColor: AppColors.primary,
      category: 'vegetables',
      isFeatured: true,
      isAvailable: true,
      stockQuantity: 150,
      // imageUrl: 'assets/images/tomatoes.png', // Add actual image paths
    ),
    ProductData(
      id: 'prod_002',
      name: 'Fresh Salmon',
      description: 'Atlantic salmon, fresh daily',
      price: '\$12.99/kg',
      unit: 'kg',
      backgroundColor: AppColors.categorySeafood,
      category: 'seafood',
      isFeatured: true,
      isAvailable: true,
      stockQuantity: 45,
      // imageUrl: 'assets/images/salmon.png',
    ),
    ProductData(
      id: 'prod_003',
      name: 'Organic Lettuce',
      description: 'Crisp organic lettuce heads',
      price: '\$2.49/kg',
      unit: 'kg',
      backgroundColor: AppColors.categoryVegetables,
      category: 'vegetables',
      isFeatured: true,
      isAvailable: true,
      stockQuantity: 200,
      // imageUrl: 'assets/images/lettuce.png',
    ),
    ProductData(
      id: 'prod_004',
      name: 'Premium Beef',
      description: 'Grade A beef cuts',
      price: '\$18.99/kg',
      unit: 'kg',
      backgroundColor: AppColors.categoryMeat,
      category: 'meat',
      isFeatured: true,
      isAvailable: true,
      stockQuantity: 75,
      // imageUrl: 'assets/images/beef.png',
    ),
  ];

  /// All available products
  static const List<ProductData> all = [
    ...featured,

    // Vegetables
    ProductData(
      id: 'prod_005',
      name: 'Carrots',
      description: 'Fresh orange carrots',
      price: '\$1.99/kg',
      unit: 'kg',
      backgroundColor: AppColors.categoryVegetables,
      category: 'vegetables',
      isAvailable: true,
      stockQuantity: 180,
    ),
    ProductData(
      id: 'prod_006',
      name: 'Broccoli',
      description: 'Fresh green broccoli',
      price: '\$3.49/kg',
      unit: 'kg',
      backgroundColor: AppColors.categoryVegetables,
      category: 'vegetables',
      isAvailable: true,
      stockQuantity: 120,
    ),
    ProductData(
      id: 'prod_007',
      name: 'Bell Peppers',
      description: 'Mixed color bell peppers',
      price: '\$2.99/kg',
      unit: 'kg',
      backgroundColor: AppColors.categoryVegetables,
      category: 'vegetables',
      isAvailable: true,
      stockQuantity: 95,
    ),

    // Meat
    ProductData(
      id: 'prod_008',
      name: 'Chicken Breast',
      description: 'Boneless chicken breast',
      price: '\$8.99/kg',
      unit: 'kg',
      backgroundColor: AppColors.categoryMeat,
      category: 'meat',
      isAvailable: true,
      stockQuantity: 85,
    ),
    ProductData(
      id: 'prod_009',
      name: 'Pork Chops',
      description: 'Fresh pork chops',
      price: '\$12.49/kg',
      unit: 'kg',
      backgroundColor: AppColors.categoryMeat,
      category: 'meat',
      isAvailable: true,
      stockQuantity: 60,
    ),
    ProductData(
      id: 'prod_010',
      name: 'Ground Turkey',
      description: 'Lean ground turkey',
      price: '\$6.99/kg',
      unit: 'kg',
      backgroundColor: AppColors.categoryMeat,
      category: 'meat',
      isAvailable: true,
      stockQuantity: 40,
    ),

    // Seafood
    ProductData(
      id: 'prod_011',
      name: 'Shrimp',
      description: 'Large fresh shrimp',
      price: '\$15.99/kg',
      unit: 'kg',
      backgroundColor: AppColors.categorySeafood,
      category: 'seafood',
      isAvailable: true,
      stockQuantity: 35,
    ),
    ProductData(
      id: 'prod_012',
      name: 'Cod Fillet',
      description: 'Fresh cod fillets',
      price: '\$10.99/kg',
      unit: 'kg',
      backgroundColor: AppColors.categorySeafood,
      category: 'seafood',
      isAvailable: true,
      stockQuantity: 50,
    ),
    ProductData(
      id: 'prod_013',
      name: 'Tuna Steaks',
      description: 'Fresh tuna steaks',
      price: '\$22.99/kg',
      unit: 'kg',
      backgroundColor: AppColors.categorySeafood,
      category: 'seafood',
      isAvailable: false, // Out of stock
      stockQuantity: 0,
    ),
  ];

  /// Get products by category
  static List<ProductData> getByCategory(String category) {
    return all.where((product) => product.category == category).toList();
  }

  /// Get available products only
  static List<ProductData> get available {
    return all.where((product) => product.isAvailable).toList();
  }

  /// Get featured products only
  static List<ProductData> get featuredOnly {
    return all.where((product) => product.isFeatured).toList();
  }

  /// Get products with low stock (less than 50)
  static List<ProductData> get lowStock {
    return all
        .where(
          (product) =>
              product.stockQuantity != null && product.stockQuantity! < 50,
        )
        .toList();
  }

  /// Search products by name
  static List<ProductData> search(String query) {
    if (query.isEmpty) return all;

    final lowercaseQuery = query.toLowerCase();
    return all
        .where(
          (product) =>
              product.name.toLowerCase().contains(lowercaseQuery) ||
              (product.description?.toLowerCase().contains(lowercaseQuery) ??
                  false),
        )
        .toList();
  }

  /// Get product by ID
  static ProductData? getById(String id) {
    try {
      return all.firstWhere((product) => product.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Get all unique categories
  static List<String> get categories {
    return all
        .where((product) => product.category != null)
        .map((product) => product.category!)
        .toSet()
        .toList();
  }
}

/// Sample order data
class OrderData {
  final String id;
  final DateTime date;
  final List<ProductData> products;
  final double total;
  final String status;
  final String? customerName;

  const OrderData({
    required this.id,
    required this.date,
    required this.products,
    required this.total,
    required this.status,
    this.customerName,
  });
}

/// Mock order data
class MockOrders {
  static final List<OrderData> recent = [
    OrderData(
      id: 'ORD-001',
      date: DateTime.now().subtract(const Duration(hours: 2)),
      products: [MockProducts.featured[0], MockProducts.featured[1]],
      total: 89.99,
      status: 'Pending',
      customerName: 'Restaurant ABC',
    ),
    OrderData(
      id: 'ORD-002',
      date: DateTime.now().subtract(const Duration(days: 1)),
      products: [MockProducts.featured[2], MockProducts.featured[3]],
      total: 156.75,
      status: 'Delivered',
      customerName: 'Cafe XYZ',
    ),
    OrderData(
      id: 'ORD-003',
      date: DateTime.now().subtract(const Duration(days: 2)),
      products: [MockProducts.featured[0]],
      total: 24.95,
      status: 'Processing',
      customerName: 'Bistro 123',
    ),
  ];
}
