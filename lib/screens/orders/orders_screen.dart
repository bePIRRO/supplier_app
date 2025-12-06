import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../../design/design_system.dart';
import '../../data/orders_data.dart';
import 'order_detail_screen.dart';

/// Orders screen for the Supplier App
/// Displays order list with filtering and status tabs
class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        title: Text(l10n.orders, style: AppTypography.h5),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: _onFilterPressed,
            icon: const Icon(Icons.filter_list, color: AppColors.textPrimary),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.primary,
          unselectedLabelColor: AppColors.textSecondary,
          indicatorColor: AppColors.primary,
          labelStyle: AppTypography.labelMedium,
          tabs: [
            Tab(text: l10n.all),
            Tab(text: l10n.pending),
            Tab(text: l10n.processing),
            Tab(text: l10n.completed),
          ],
        ),
      ),
      body: Column(
        children: [
          // Search Bar
          _buildSearchBar(l10n),

          // Orders List
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildOrdersList(OrderStatus.all),
                _buildOrdersList(OrderStatus.pending),
                _buildOrdersList(OrderStatus.processing),
                _buildOrdersList(OrderStatus.completed),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onCreateOrder,
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, color: AppColors.white),
      ),
    );
  }

  Widget _buildSearchBar(AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.screenPadding),
      color: AppColors.surface,
      child: TextField(
        onChanged: (value) {
          setState(() {
            _searchQuery = value;
          });
        },
        decoration: AppInputStyles.searchInput.copyWith(
          hintText: l10n.searchOrders,
          prefixIcon: const Icon(Icons.search, color: AppColors.textSecondary),
        ),
        style: AppTypography.inputText,
      ),
    );
  }

  Widget _buildOrdersList(OrderStatus status) {
    final filteredOrders = _getFilteredOrders(status);

    if (filteredOrders.isEmpty) {
      return _buildEmptyState();
    }

    return ListView.separated(
      padding: const EdgeInsets.all(AppSpacing.screenPadding),
      itemCount: filteredOrders.length,
      separatorBuilder: (context, index) =>
          const SizedBox(height: AppSpacing.spaceMd),
      itemBuilder: (context, index) {
        final order = filteredOrders[index];
        return _OrderCard(order: order, onTap: () => _onOrderTapped(order));
      },
    );
  }

  Widget _buildEmptyState() {
    final l10n = AppLocalizations.of(context)!;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_bag_outlined,
            size: 64,
            color: AppColors.textSecondary.withValues(alpha: 0.5),
          ),
          const SizedBox(height: AppSpacing.spaceMd),
          Text(
            l10n.noOrdersFound,
            style: AppTypography.bodyLarge.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppSpacing.spaceSm),
          Text(
            l10n.noOrdersDescription,
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  List<OrderData> _getFilteredOrders(OrderStatus status) {
    var orders = OrdersData.sampleOrders;

    // Filter by status
    if (status != OrderStatus.all) {
      orders = orders.where((o) => o.status == status).toList();
    }

    // Filter by search query
    if (_searchQuery.isNotEmpty) {
      orders = orders
          .where(
            (o) =>
                o.orderNumber.toLowerCase().contains(
                  _searchQuery.toLowerCase(),
                ) ||
                o.customerName.toLowerCase().contains(
                  _searchQuery.toLowerCase(),
                ),
          )
          .toList();
    }

    return orders;
  }

  void _onFilterPressed() {
    final l10n = AppLocalizations.of(context)!;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(l10n.filterComingSoon)));
  }

  void _onCreateOrder() {
    final l10n = AppLocalizations.of(context)!;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(l10n.navigateToCreateOrder)));
  }

  void _onOrderTapped(OrderData order) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => OrderDetailScreen(order: order)),
    );
  }
}

/// Order card widget
class _OrderCard extends StatelessWidget {
  final OrderData order;
  final VoidCallback? onTap;

  const _OrderCard({required this.order, this.onTap});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Card(
      elevation: AppElevation.sm,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.cardRadius),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.cardRadius),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.paddingMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Order header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(order.orderNumber, style: AppTypography.h6),
                  _StatusBadge(status: order.status),
                ],
              ),

              const SizedBox(height: AppSpacing.spaceSm),

              // Customer name
              Row(
                children: [
                  const Icon(
                    Icons.person_outline,
                    size: AppSizes.iconSm,
                    color: AppColors.textSecondary,
                  ),
                  const SizedBox(width: AppSpacing.spaceXs),
                  Text(
                    order.customerName,
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: AppSpacing.spaceXs),

              // Order date
              Row(
                children: [
                  const Icon(
                    Icons.calendar_today_outlined,
                    size: AppSizes.iconSm,
                    color: AppColors.textSecondary,
                  ),
                  const SizedBox(width: AppSpacing.spaceXs),
                  Text(
                    order.date,
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),

              const Divider(height: AppSpacing.spaceLg),

              // Order summary
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${order.itemCount} ${l10n.items}',
                    style: AppTypography.bodyMedium,
                  ),
                  Text(
                    order.total,
                    style: AppTypography.h6.copyWith(color: AppColors.primary),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Status badge widget
class _StatusBadge extends StatelessWidget {
  final OrderStatus status;

  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.paddingSm,
        vertical: AppSpacing.paddingXs,
      ),
      decoration: BoxDecoration(
        color: _getStatusColor().withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppRadius.radiusFull),
      ),
      child: Text(
        _getStatusText(l10n),
        style: AppTypography.labelSmall.copyWith(
          color: _getStatusColor(),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Color _getStatusColor() {
    switch (status) {
      case OrderStatus.pending:
        return AppColors.warning;
      case OrderStatus.processing:
        return AppColors.info;
      case OrderStatus.completed:
        return AppColors.success;
      case OrderStatus.cancelled:
        return AppColors.error;
      case OrderStatus.all:
        return AppColors.textSecondary;
    }
  }

  String _getStatusText(AppLocalizations l10n) {
    switch (status) {
      case OrderStatus.pending:
        return l10n.pending;
      case OrderStatus.processing:
        return l10n.processing;
      case OrderStatus.completed:
        return l10n.completed;
      case OrderStatus.cancelled:
        return l10n.cancelled;
      case OrderStatus.all:
        return l10n.all;
    }
  }
}
