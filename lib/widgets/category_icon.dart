import 'package:flutter/material.dart';
import '../design/design_system.dart';

/// Reusable category icon widget for displaying product categories
/// Based on the meat, vegetables, seafood icons from the design
class CategoryIcon extends StatelessWidget {
  /// Category name/label
  final String label;

  /// Icon to display
  final IconData icon;

  /// Category color
  final Color? color;

  /// Whether this category is selected
  final bool isSelected;

  /// Callback when category is tapped
  final VoidCallback? onTap;

  /// Size variant of the category icon
  final CategoryIconSize size;

  const CategoryIcon({
    super.key,
    required this.label,
    required this.icon,
    this.color,
    this.isSelected = false,
    this.onTap,
    this.size = CategoryIconSize.medium,
  });

  @override
  Widget build(BuildContext context) {
    final categoryColor = color ?? AppColors.textSecondary;
    final iconSize = _getIconSize();
    final containerSize = _getContainerSize();

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: containerSize,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon Container
            Container(
              width: containerSize,
              height: containerSize,
              decoration: isSelected
                  ? AppCategoryStyles.categoryIconSelected.copyWith(
                      color: categoryColor.withOpacity(0.1),
                      border: Border.all(color: categoryColor, width: 2),
                    )
                  : AppCategoryStyles.categoryIcon,
              child: Icon(
                icon,
                size: iconSize,
                color: isSelected ? categoryColor : AppColors.textSecondary,
              ),
            ),

            const SizedBox(height: AppSpacing.spaceXs),

            // Category Label
            Text(
              label,
              style: _getLabelStyle().copyWith(
                color: isSelected ? categoryColor : AppColors.textSecondary,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  double _getIconSize() {
    switch (size) {
      case CategoryIconSize.small:
        return AppSizes.iconSm;
      case CategoryIconSize.medium:
        return AppSizes.iconMd;
      case CategoryIconSize.large:
        return AppSizes.iconLg;
    }
  }

  double _getContainerSize() {
    switch (size) {
      case CategoryIconSize.small:
        return 48.0;
      case CategoryIconSize.medium:
        return 64.0;
      case CategoryIconSize.large:
        return 80.0;
    }
  }

  TextStyle _getLabelStyle() {
    switch (size) {
      case CategoryIconSize.small:
        return AppTypography.labelSmall;
      case CategoryIconSize.medium:
        return AppTypography.categoryLabel;
      case CategoryIconSize.large:
        return AppTypography.labelMedium;
    }
  }
}

/// Predefined category icons for common food categories
class FoodCategoryIcons {
  static const CategoryIcon meat = CategoryIcon(
    label: 'Meat',
    icon: Icons.restaurant_outlined,
    color: AppColors.categoryMeat,
  );

  static const CategoryIcon vegetables = CategoryIcon(
    label: 'Vegetables',
    icon: Icons.eco_outlined,
    color: AppColors.categoryVegetables,
  );

  static const CategoryIcon seafood = CategoryIcon(
    label: 'Seafood',
    icon: Icons.waves_outlined,
    color: AppColors.categorySeafood,
  );

  static const CategoryIcon dairy = CategoryIcon(
    label: 'Dairy',
    icon: Icons.local_drink_outlined,
    color: AppColors.textSecondary,
  );

  static const CategoryIcon fruits = CategoryIcon(
    label: 'Fruits',
    icon: Icons.apple_outlined,
    color: AppColors.primary,
  );

  static const CategoryIcon grains = CategoryIcon(
    label: 'Grains',
    icon: Icons.grain_outlined,
    color: AppColors.secondary,
  );
}

/// Category icon size enumeration
enum CategoryIconSize {
  small, // 48px container, 20px icon
  medium, // 64px container, 24px icon
  large, // 80px container, 32px icon
}

/// Horizontal scrollable list of category icons
class CategoryIconList extends StatelessWidget {
  final List<CategoryIconData> categories;
  final String? selectedCategory;
  final Function(String)? onCategorySelected;
  final CategoryIconSize size;
  final EdgeInsets? padding;

  const CategoryIconList({
    super.key,
    required this.categories,
    this.selectedCategory,
    this.onCategorySelected,
    this.size = CategoryIconSize.medium,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _getListHeight(),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding:
            padding ??
            const EdgeInsets.symmetric(horizontal: AppSpacing.screenPadding),
        itemCount: categories.length,
        separatorBuilder: (context, index) =>
            const SizedBox(width: AppSpacing.spaceMd),
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = selectedCategory == category.id;

          return CategoryIcon(
            label: category.label,
            icon: category.icon,
            color: category.color,
            isSelected: isSelected,
            size: size,
            onTap: () => onCategorySelected?.call(category.id),
          );
        },
      ),
    );
  }

  double _getListHeight() {
    switch (size) {
      case CategoryIconSize.small:
        return 80.0; // 48 + 4 + 28 (icon + spacing + text)
      case CategoryIconSize.medium:
        return 100.0; // 64 + 4 + 32
      case CategoryIconSize.large:
        return 120.0; // 80 + 4 + 36
    }
  }
}

/// Data class for category icon information
class CategoryIconData {
  final String id;
  final String label;
  final IconData icon;
  final Color? color;

  const CategoryIconData({
    required this.id,
    required this.label,
    required this.icon,
    this.color,
  });
}

/// Predefined category data for common food categories
class FoodCategories {
  static const List<CategoryIconData> all = [
    CategoryIconData(
      id: 'meat',
      label: 'Meat',
      icon: Icons.restaurant_outlined,
      color: AppColors.categoryMeat,
    ),
    CategoryIconData(
      id: 'vegetables',
      label: 'Vegetables',
      icon: Icons.eco_outlined,
      color: AppColors.categoryVegetables,
    ),
    CategoryIconData(
      id: 'seafood',
      label: 'Seafood',
      icon: Icons.waves_outlined,
      color: AppColors.categorySeafood,
    ),
    CategoryIconData(
      id: 'dairy',
      label: 'Dairy',
      icon: Icons.local_drink_outlined,
      color: AppColors.textSecondary,
    ),
    CategoryIconData(
      id: 'fruits',
      label: 'Fruits',
      icon: Icons.apple_outlined,
      color: AppColors.primary,
    ),
    CategoryIconData(
      id: 'grains',
      label: 'Grains',
      icon: Icons.grain_outlined,
      color: AppColors.secondary,
    ),
  ];

  static const List<CategoryIconData> main = [
    CategoryIconData(
      id: 'meat',
      label: 'Meat',
      icon: Icons.restaurant_outlined,
      color: AppColors.categoryMeat,
    ),
    CategoryIconData(
      id: 'vegetables',
      label: 'Vegetables',
      icon: Icons.eco_outlined,
      color: AppColors.categoryVegetables,
    ),
    CategoryIconData(
      id: 'seafood',
      label: 'Seafood',
      icon: Icons.waves_outlined,
      color: AppColors.categorySeafood,
    ),
  ];
}
