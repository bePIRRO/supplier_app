import 'package:flutter/material.dart';
import '../design/design_system.dart';

/// Reusable product card widget for displaying featured products
/// Based on the tomatoes card design from the mockup
class ProductCard extends StatelessWidget {
  /// Product name/title
  final String title;

  /// Product image asset path or URL
  final String? imageUrl;

  /// Product price (optional)
  final String? price;

  /// Background color of the card
  final Color? backgroundColor;

  /// Callback when "Add to Order" button is pressed
  final VoidCallback? onAddToOrder;

  /// Whether the card is featured (affects styling)
  final bool isFeatured;

  const ProductCard({
    super.key,
    required this.title,
    this.imageUrl,
    this.price,
    this.backgroundColor,
    this.onAddToOrder,
    this.isFeatured = false,
  });

  @override
  Widget build(BuildContext context) {
    final cardBackground = backgroundColor ?? AppColors.primary;

    return Container(
      width: 200,
      height: AppSizes.productCardHeight,
      decoration: BoxDecoration(
        color: cardBackground,
        borderRadius: BorderRadius.circular(AppRadius.cardRadius),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: AppElevation.cardElevation,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.cardPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Title
            Text(
              title,
              style: AppTypography.productTitle.copyWith(
                color: _getTextColor(cardBackground),
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),

            const SizedBox(height: AppSpacing.spaceSm),

            // Product Image
            Expanded(child: Center(child: _buildProductImage())),

            const SizedBox(height: AppSpacing.spaceSm),

            // Price (if provided)
            if (price != null) ...[
              Text(
                price!,
                style: AppTypography.productPrice.copyWith(
                  color: _getTextColor(cardBackground),
                ),
              ),
              const SizedBox(height: AppSpacing.spaceSm),
            ],

            // Add to Order Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onAddToOrder,
                style: AppButtonStyles.addToOrderButton.copyWith(
                  backgroundColor: MaterialStateProperty.all(
                    _getButtonColor(cardBackground),
                  ),
                  foregroundColor: MaterialStateProperty.all(
                    _getButtonTextColor(cardBackground),
                  ),
                ),
                child: const Text('Add to Order'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductImage() {
    if (imageUrl != null) {
      // Handle both network and asset images
      if (imageUrl!.startsWith('http')) {
        return Image.network(
          imageUrl!,
          height: AppSizes.productImageHeight,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) => _buildPlaceholderIcon(),
        );
      } else {
        return Image.asset(
          imageUrl!,
          height: AppSizes.productImageHeight,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) => _buildPlaceholderIcon(),
        );
      }
    }

    return _buildPlaceholderIcon();
  }

  Widget _buildPlaceholderIcon() {
    return Container(
      height: AppSizes.productImageHeight,
      width: AppSizes.productImageHeight,
      decoration: BoxDecoration(
        color: AppColors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(AppRadius.radiusMd),
      ),
      child: Icon(
        Icons.shopping_basket_outlined,
        size: AppSizes.iconLg,
        color: AppColors.white.withOpacity(0.7),
      ),
    );
  }

  Color _getTextColor(Color backgroundColor) {
    // Use white text on dark/colored backgrounds, dark text on light backgrounds
    return backgroundColor.computeLuminance() > 0.5
        ? AppColors.textPrimary
        : AppColors.white;
  }

  Color _getButtonColor(Color backgroundColor) {
    // Use white button on colored backgrounds
    return backgroundColor == AppColors.white
        ? AppColors.backgroundSecondary
        : AppColors.white;
  }

  Color _getButtonTextColor(Color backgroundColor) {
    // Use dark text on white button
    return AppColors.textPrimary;
  }
}

/// Specialized product card variants for common use cases
class FeaturedProductCard extends ProductCard {
  const FeaturedProductCard({
    super.key,
    required super.title,
    super.imageUrl,
    super.price,
    super.onAddToOrder,
  }) : super(backgroundColor: AppColors.primary, isFeatured: true);
}

class CategoryProductCard extends ProductCard {
  const CategoryProductCard({
    super.key,
    required super.title,
    super.imageUrl,
    super.price,
    super.onAddToOrder,
    Color? categoryColor,
  }) : super(backgroundColor: categoryColor ?? AppColors.backgroundSecondary);
}

/// Product card for list/grid layouts
class CompactProductCard extends StatelessWidget {
  final String title;
  final String? imageUrl;
  final String? price;
  final VoidCallback? onTap;
  final VoidCallback? onAddToOrder;

  const CompactProductCard({
    super.key,
    required this.title,
    this.imageUrl,
    this.price,
    this.onTap,
    this.onAddToOrder,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.cardRadius),
      child: Container(
        decoration: AppCardStyles.basicCard,
        padding: const EdgeInsets.all(AppSpacing.paddingMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            if (imageUrl != null)
              Container(
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppRadius.radiusMd),
                  color: AppColors.backgroundSecondary,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(AppRadius.radiusMd),
                  child: Image.network(
                    imageUrl!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const Icon(
                      Icons.image_outlined,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ),

            const SizedBox(height: AppSpacing.spaceSm),

            // Product Title
            Text(
              title,
              style: AppTypography.bodyMedium,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),

            if (price != null) ...[
              const SizedBox(height: AppSpacing.spaceXs),
              Text(
                price!,
                style: AppTypography.labelMedium.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],

            if (onAddToOrder != null) ...[
              const SizedBox(height: AppSpacing.spaceSm),
              SizedBox(
                width: double.infinity,
                height: 32,
                child: ElevatedButton(
                  onPressed: onAddToOrder,
                  style: AppButtonStyles.primaryButtonSmall,
                  child: const Text('Add'),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
