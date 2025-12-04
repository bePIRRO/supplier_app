/// Order status enum
enum OrderStatus { all, pending, processing, completed, cancelled }

/// Order data model
class OrderData {
  final String orderNumber;
  final String customerName;
  final String date;
  final int itemCount;
  final String total;
  final OrderStatus status;

  const OrderData({
    required this.orderNumber,
    required this.customerName,
    required this.date,
    required this.itemCount,
    required this.total,
    required this.status,
  });
}

/// Sample orders data for the Supplier App
class OrdersData {
  static const List<OrderData> sampleOrders = [
    OrderData(
      orderNumber: 'ORD-2024-001',
      customerName: 'John Smith',
      date: 'Dec 4, 2025',
      itemCount: 5,
      total: '\$156.99',
      status: OrderStatus.pending,
    ),
    OrderData(
      orderNumber: 'ORD-2024-002',
      customerName: 'Sarah Johnson',
      date: 'Dec 3, 2025',
      itemCount: 3,
      total: '\$89.50',
      status: OrderStatus.processing,
    ),
    OrderData(
      orderNumber: 'ORD-2024-003',
      customerName: 'Mike Wilson',
      date: 'Dec 2, 2025',
      itemCount: 8,
      total: '\$234.00',
      status: OrderStatus.completed,
    ),
    OrderData(
      orderNumber: 'ORD-2024-004',
      customerName: 'Emily Brown',
      date: 'Dec 1, 2025',
      itemCount: 2,
      total: '\$45.99',
      status: OrderStatus.completed,
    ),
    OrderData(
      orderNumber: 'ORD-2024-005',
      customerName: 'David Lee',
      date: 'Nov 30, 2025',
      itemCount: 6,
      total: '\$178.50',
      status: OrderStatus.pending,
    ),
    OrderData(
      orderNumber: 'ORD-2024-006',
      customerName: 'Lisa Anderson',
      date: 'Nov 29, 2025',
      itemCount: 4,
      total: '\$112.00',
      status: OrderStatus.cancelled,
    ),
  ];

  /// Get orders filtered by status
  static List<OrderData> getOrdersByStatus(OrderStatus status) {
    if (status == OrderStatus.all) {
      return sampleOrders;
    }
    return sampleOrders.where((order) => order.status == status).toList();
  }

  /// Search orders by order number or customer name
  static List<OrderData> searchOrders(String query, {OrderStatus? status}) {
    var orders = status != null && status != OrderStatus.all
        ? getOrdersByStatus(status)
        : sampleOrders;

    if (query.isEmpty) {
      return orders;
    }

    return orders
        .where(
          (order) =>
              order.orderNumber.toLowerCase().contains(query.toLowerCase()) ||
              order.customerName.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();
  }

  /// Get count of orders by status
  static int getOrderCount(OrderStatus status) {
    return getOrdersByStatus(status).length;
  }

  /// Get pending orders count (for badge)
  static int get pendingCount => getOrderCount(OrderStatus.pending);
}
