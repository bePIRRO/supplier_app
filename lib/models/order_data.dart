import 'package:supplier_app/models/product_data.dart';

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
