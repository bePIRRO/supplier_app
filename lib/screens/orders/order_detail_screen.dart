import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../../design/design_system.dart';
import '../../data/orders_data.dart';

/// Order detail screen displaying full order information
class OrderDetailScreen extends StatefulWidget {
  final OrderData order;

  const OrderDetailScreen({super.key, required this.order});

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  bool _showAllItems = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final order = widget.order;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
        ),
        title: Text(l10n.orderDetails, style: AppTypography.h5),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => _showMoreOptions(context),
            icon: const Icon(Icons.more_vert, color: AppColors.textPrimary),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.paddingMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order header card
            _OrderHeaderCard(order: order),
            const SizedBox(height: AppSpacing.spaceMd),

            // Customer info section
            _SectionCard(
              title: l10n.customerInfo,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _InfoRow(
                    icon: Icons.person_outline,
                    label: l10n.customerName,
                    value: order.customerName,
                  ),
                  const SizedBox(height: AppSpacing.spaceSm),
                  _InfoRow(
                    icon: Icons.phone_outlined,
                    label: l10n.phone,
                    value: '+1 (555) 123-4567',
                  ),
                  const SizedBox(height: AppSpacing.spaceSm),
                  _InfoRow(
                    icon: Icons.email_outlined,
                    label: l10n.email,
                    value:
                        '${order.customerName.toLowerCase().replaceAll(' ', '.')}@email.com',
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.spaceMd),

            // Delivery info section
            _SectionCard(
              title: l10n.deliveryInfo,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _InfoRow(
                    icon: Icons.location_on_outlined,
                    label: l10n.deliveryAddress,
                    value: '123 Main Street, Suite 100\nNew York, NY 10001',
                  ),
                  const SizedBox(height: AppSpacing.spaceSm),
                  _InfoRow(
                    icon: Icons.calendar_today_outlined,
                    label: l10n.deliveryDate,
                    value: order.date,
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.spaceMd),

            // Order items section
            _SectionCard(
              title: '${l10n.items} (${order.itemCount})',
              child: Column(
                children: List.generate(
                  _showAllItems
                      ? order.itemCount
                      : (order.itemCount > 3 ? 3 : order.itemCount),
                  (index) => _OrderItemRow(
                    name: 'Product ${index + 1}',
                    quantity: index + 1,
                    price: '\$${(29.99 * (index + 1)).toStringAsFixed(2)}',
                    isLast:
                        index ==
                        (_showAllItems
                            ? order.itemCount - 1
                            : (order.itemCount > 3 ? 2 : order.itemCount - 1)),
                  ),
                ),
              ),
            ),
            if (order.itemCount > 3) ...[
              const SizedBox(height: AppSpacing.spaceXs),
              Center(
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      _showAllItems = !_showAllItems;
                    });
                  },
                  child: Text(
                    _showAllItems
                        ? 'Show less'
                        : '+ ${order.itemCount - 3} more items',
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),
            ],
            const SizedBox(height: AppSpacing.spaceMd),

            // Order summary section
            _SectionCard(
              title: l10n.orderSummary,
              child: Column(
                children: [
                  _SummaryRow(label: l10n.subtotal, value: order.total),
                  const SizedBox(height: AppSpacing.spaceXs),
                  _SummaryRow(label: l10n.shipping, value: '\$10.00'),
                  const SizedBox(height: AppSpacing.spaceXs),
                  _SummaryRow(label: l10n.tax, value: '\$12.50'),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: AppSpacing.spaceSm),
                    child: Divider(color: AppColors.border),
                  ),
                  _SummaryRow(
                    label: l10n.total,
                    value: order.total,
                    isTotal: true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.spaceXl),
          ],
        ),
      ),
      bottomNavigationBar: _BottomActions(order: order),
    );
  }

  void _showMoreOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppRadius.radiusXl),
        ),
      ),
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.paddingMd),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.print_outlined),
                title: const Text('Print Order'),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                leading: const Icon(Icons.share_outlined),
                title: const Text('Share Order'),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                leading: const Icon(
                  Icons.cancel_outlined,
                  color: AppColors.error,
                ),
                title: const Text(
                  'Cancel Order',
                  style: TextStyle(color: AppColors.error),
                ),
                onTap: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Order header card with status badge
class _OrderHeaderCard extends StatelessWidget {
  final OrderData order;

  const _OrderHeaderCard({required this.order});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.paddingMd),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.cardRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: AppElevation.sm,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                order.orderNumber,
                style: AppTypography.h5.copyWith(fontWeight: FontWeight.bold),
              ),
              _StatusBadge(status: order.status),
            ],
          ),
          const SizedBox(height: AppSpacing.spaceSm),
          Row(
            children: [
              Icon(
                Icons.calendar_today_outlined,
                size: 16,
                color: AppColors.textSecondary,
              ),
              const SizedBox(width: AppSpacing.spaceXs),
              Text(
                order.date,
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(width: AppSpacing.spaceMd),
              Icon(
                Icons.shopping_bag_outlined,
                size: 16,
                color: AppColors.textSecondary,
              ),
              const SizedBox(width: AppSpacing.spaceXs),
              Text(
                '${order.itemCount} ${l10n.items}',
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ],
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
        color: _getStatusColor().withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppRadius.radiusSm),
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

/// Section card container
class _SectionCard extends StatelessWidget {
  final String title;
  final Widget child;

  const _SectionCard({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.paddingMd),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.cardRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: AppElevation.sm,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTypography.h6.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: AppSpacing.spaceMd),
          child,
        ],
      ),
    );
  }
}

/// Info row widget
class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: AppColors.textSecondary),
        const SizedBox(width: AppSpacing.spaceSm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppTypography.labelSmall.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 2),
              Text(value, style: AppTypography.bodyMedium),
            ],
          ),
        ),
      ],
    );
  }
}

/// Order item row
class _OrderItemRow extends StatelessWidget {
  final String name;
  final int quantity;
  final String price;
  final bool isLast;

  const _OrderItemRow({
    required this.name,
    required this.quantity,
    required this.price,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.paddingSm),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(AppRadius.radiusSm),
                ),
                child: const Icon(
                  Icons.inventory_2_outlined,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(width: AppSpacing.spaceSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: AppTypography.bodyMedium),
                    Text(
                      'Qty: $quantity',
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                price,
                style: AppTypography.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        if (!isLast) const Divider(color: AppColors.border, height: 1),
      ],
    );
  }
}

/// Summary row widget
class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isTotal;

  const _SummaryRow({
    required this.label,
    required this.value,
    this.isTotal = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: isTotal
              ? AppTypography.bodyLarge.copyWith(fontWeight: FontWeight.w600)
              : AppTypography.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
        ),
        Text(
          value,
          style: isTotal
              ? AppTypography.h5.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                )
              : AppTypography.bodyMedium,
        ),
      ],
    );
  }
}

/// Bottom action buttons
class _BottomActions extends StatelessWidget {
  final OrderData order;

  const _BottomActions({required this.order});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.paddingMd),
      decoration: BoxDecoration(
        color: AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: AppElevation.md,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    vertical: AppSpacing.paddingMd,
                  ),
                  side: const BorderSide(color: AppColors.primary),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadius.buttonRadius),
                  ),
                ),
                child: Text(
                  l10n.contactCustomer,
                  style: AppTypography.labelMedium.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.spaceMd),
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(
                    vertical: AppSpacing.paddingMd,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadius.buttonRadius),
                  ),
                ),
                child: Text(
                  _getActionText(l10n),
                  style: AppTypography.labelMedium.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getActionText(AppLocalizations l10n) {
    switch (order.status) {
      case OrderStatus.pending:
        return l10n.startProcessing;
      case OrderStatus.processing:
        return l10n.markCompleted;
      case OrderStatus.completed:
        return l10n.viewInvoice;
      case OrderStatus.cancelled:
        return l10n.reorder;
      case OrderStatus.all:
        return l10n.viewDetails;
    }
  }
}
