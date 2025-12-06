import 'product_data.dart';

/// Cart item model representing a product with quantity in the cart
class CartItem {
  final ProductData product;
  final int quantity;

  const CartItem({required this.product, required this.quantity});

  /// Calculate total price for this cart item
  double get total {
    // Extract numeric price from string like "$4.99/kg"
    final priceStr = product.price?.replaceAll(RegExp(r'[^\d.]'), '') ?? '0';
    final price = double.tryParse(priceStr) ?? 0;
    return price * quantity;
  }

  /// Create a copy with updated quantity
  CartItem copyWith({int? quantity}) {
    return CartItem(product: product, quantity: quantity ?? this.quantity);
  }
}
