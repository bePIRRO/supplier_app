import 'package:flutter/material.dart';
import '../design/design_system.dart';
import '../widgets/product_card.dart';
import '../widgets/category_icon.dart';
import '../widgets/action_button.dart';
import '../widgets/bottom_navigation.dart';

/// Home screen for the Supplier App
/// Displays featured products, categories, and main actions
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentNavIndex = 0;
  String? _selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              _buildHeader(),

              const SizedBox(height: AppSpacing.spaceLg),

              // Featured Products Section
              _buildFeaturedProducts(),

              const SizedBox(height: AppSpacing.spaceLg),

              // Categories Section
              _buildCategories(),

              const SizedBox(height: AppSpacing.spaceLg),

              // Action Buttons Section
              _buildActionButtons(),

              const SizedBox(height: AppSpacing.space2xl),
            ],
          ),
        ),
      ),
      bottomNavigationBar: AppBottomNavigation(
        currentIndex: _currentNavIndex,
        onTap: _onNavItemTapped,
        items: SupplierNavItems.withBadges(ordersBadge: 3, cartBadge: 2),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.screenPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo
          Container(
            padding: const EdgeInsets.all(AppSpacing.paddingSm),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(AppRadius.radiusMd),
            ),
            child: const Icon(
              Icons.close,
              color: AppColors.white,
              size: AppSizes.iconMd,
            ),
          ),

          // Logo Text
          const Text('logo', style: AppTypography.logoText),

          // Action Icons
          Row(
            children: [
              IconButton(
                onPressed: _onSearchPressed,
                icon: const Icon(
                  Icons.search,
                  color: AppColors.textPrimary,
                  size: AppSizes.iconMd,
                ),
              ),
              IconButton(
                onPressed: _onNotificationPressed,
                icon: const Icon(
                  Icons.notifications_outlined,
                  color: AppColors.textPrimary,
                  size: AppSizes.iconMd,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedProducts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Title
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.screenPadding),
          child: Text('Featured Products', style: AppTypography.h4),
        ),

        const SizedBox(height: AppSpacing.spaceMd),

        // Products List
        SizedBox(
          height: AppSizes.productCardHeight + 32,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.screenPadding,
            ),
            itemCount: _featuredProducts.length,
            separatorBuilder: (context, index) =>
                const SizedBox(width: AppSpacing.spaceMd),
            itemBuilder: (context, index) {
              final product = _featuredProducts[index];
              return ProductCard(
                title: product.name,
                imageUrl: product.imageUrl,
                price: product.price,
                backgroundColor: product.backgroundColor,
                onAddToOrder: () => _onAddToOrder(product),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCategories() {
    return Column(
      children: [
        // Categories List
        CategoryIconList(
          categories: FoodCategories.main,
          selectedCategory: _selectedCategory,
          onCategorySelected: (categoryId) {
            setState(() {
              _selectedCategory = _selectedCategory == categoryId
                  ? null
                  : categoryId;
            });
          },
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenPadding),
      child: Row(
        children: [
          // Create Order Button
          Expanded(
            child: ActionButton.primary(
              title: 'Create Order',
              icon: Icons.add_shopping_cart_outlined,
              onPressed: _onCreateOrder,
            ),
          ),

          const SizedBox(width: AppSpacing.spaceMd),

          // Invoices Button
          Expanded(
            child: ActionButton.secondary(
              title: 'Invoices',
              icon: Icons.receipt_long_outlined,
              onPressed: _onInvoices,
            ),
          ),
        ],
      ),
    );
  }

  void _onNavItemTapped(int index) {
    setState(() {
      _currentNavIndex = index;
    });

    // TODO: Navigate to different screens based on index
    switch (index) {
      case 0: // Home
        break;
      case 1: // Orders
        _navigateToOrders();
        break;
      case 2: // Cart
        _navigateToCart();
        break;
      case 3: // Profile
        _navigateToProfile();
        break;
    }
  }

  void _onSearchPressed() {
    // TODO: Implement search functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Search functionality coming soon!')),
    );
  }

  void _onNotificationPressed() {
    // TODO: Implement notification functionality
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Notifications coming soon!')));
  }

  void _onAddToOrder(ProductData product) {
    // TODO: Implement add to order functionality
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product.name} added to order!'),
        backgroundColor: AppColors.success,
      ),
    );
  }

  void _onCreateOrder() {
    // TODO: Navigate to create order screen
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Navigate to Create Order screen')),
    );
  }

  void _onInvoices() {
    // TODO: Navigate to invoices screen
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Navigate to Invoices screen')),
    );
  }

  void _navigateToOrders() {
    // TODO: Navigate to orders screen
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Navigate to Orders screen')));
  }

  void _navigateToCart() {
    // TODO: Navigate to cart screen
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Navigate to Cart screen')));
  }

  void _navigateToProfile() {
    // TODO: Navigate to profile screen
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Navigate to Profile screen')));
  }
}

/// Sample data for featured products
class ProductData {
  final String name;
  final String? imageUrl;
  final String? price;
  final Color? backgroundColor;

  const ProductData({
    required this.name,
    this.imageUrl,
    this.price,
    this.backgroundColor,
  });
}

/// Sample featured products data
final List<ProductData> _featuredProducts = [
  const ProductData(
    name: 'Tomatoes',
    price: '\$4.99/kg',
    backgroundColor: AppColors.primary,
    // imageUrl: 'assets/images/tomatoes.png', // Add actual image paths
  ),
  const ProductData(
    name: 'Fresh Salmon',
    price: '\$12.99/kg',
    backgroundColor: AppColors.categorySeafood,
  ),
  const ProductData(
    name: 'Organic Lettuce',
    price: '\$2.49/kg',
    backgroundColor: AppColors.categoryVegetables,
  ),
  const ProductData(
    name: 'Premium Beef',
    price: '\$18.99/kg',
    backgroundColor: AppColors.categoryMeat,
  ),
];
