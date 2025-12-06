import '../models/cart_item.dart';
import 'mock_products_data.dart';

/// Sample cart data for the Supplier App
class CartData {
  static final List<CartItem> sampleCartItems = [
    CartItem(
      product: MockProducts.featured[0], // Tomatoes
      quantity: 5,
    ),
    CartItem(
      product: MockProducts.featured[1], // Fresh Salmon
      quantity: 2,
    ),
    CartItem(
      product: MockProducts.featured[2], // Organic Lettuce
      quantity: 3,
    ),
    CartItem(
      product: MockProducts.all[4], // Carrots
      quantity: 4,
    ),
    CartItem(
      product: MockProducts.all[5], // Broccoli
      quantity: 2,
    ),
  ];

  /// Calculate subtotal from cart items
  static double calculateSubtotal(List<CartItem> items) {
    return items.fold(0, (sum, item) => sum + item.total);
  }

  /// Calculate tax (assuming 10%)
  static double calculateTax(double subtotal) {
    return subtotal * 0.10;
  }

  /// Calculate total
  static double calculateTotal(List<CartItem> items) {
    final subtotal = calculateSubtotal(items);
    final tax = calculateTax(subtotal);
    return subtotal + tax;
  }
}
