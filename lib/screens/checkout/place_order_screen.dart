import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../../design/design_system.dart';
import '../../models/cart_item.dart';

/// Place order screen showing order confirmation and success
class PlaceOrderScreen extends StatefulWidget {
  final List<CartItem> cartItems;
  final double subtotal;
  final double tax;
  final double total;
  final String address;
  final String city;
  final String state;
  final String zipCode;
  final String phone;
  final String email;
  final String paymentMethod;
  final String? notes;

  const PlaceOrderScreen({
    super.key,
    required this.cartItems,
    required this.subtotal,
    required this.tax,
    required this.total,
    required this.address,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.phone,
    required this.email,
    required this.paymentMethod,
    this.notes,
  });

  @override
  State<PlaceOrderScreen> createState() => _PlaceOrderScreenState();
}

class _PlaceOrderScreenState extends State<PlaceOrderScreen> {
  bool _isProcessing = false;
  bool _orderPlaced = false;
  String _orderNumber = '';

  @override
  void initState() {
    super.initState();
    // Generate order number
    _orderNumber = 'ORD-${DateTime.now().millisecondsSinceEpoch}';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    if (_orderPlaced) {
      return _buildSuccessScreen(l10n);
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
        ),
        title: Text(l10n.placeOrderTitle, style: AppTypography.h5),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.paddingMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Review message
            Container(
              padding: const EdgeInsets.all(AppSpacing.paddingMd),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppRadius.radiusMd),
                border: Border.all(
                  color: AppColors.primary.withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                children: [
                  const Icon(Icons.info_outline, color: AppColors.primary),
                  const SizedBox(width: AppSpacing.spaceMd),
                  Expanded(
                    child: Text(
                      l10n.reviewYourOrder,
                      style: AppTypography.bodyMedium,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.spaceMd),

            // Delivery Information
            _InfoCard(
              title: l10n.deliveryInformation,
              icon: Icons.location_on_outlined,
              children: [
                Text(widget.address, style: AppTypography.bodyMedium),
                Text(
                  '${widget.city}, ${widget.state} ${widget.zipCode}',
                  style: AppTypography.bodyMedium,
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.spaceMd),

            // Contact Information
            _InfoCard(
              title: l10n.contactInformation,
              icon: Icons.contact_phone_outlined,
              children: [
                Text(widget.phone, style: AppTypography.bodyMedium),
                Text(widget.email, style: AppTypography.bodyMedium),
              ],
            ),
            const SizedBox(height: AppSpacing.spaceMd),

            // Payment Method
            _InfoCard(
              title: l10n.paymentMethod,
              icon: Icons.payment_outlined,
              children: [
                Text(_getPaymentMethodName(), style: AppTypography.bodyMedium),
              ],
            ),
            const SizedBox(height: AppSpacing.spaceMd),

            // Delivery Notes (if any)
            if (widget.notes != null && widget.notes!.isNotEmpty) ...[
              _InfoCard(
                title: l10n.deliveryNotes,
                icon: Icons.note_outlined,
                children: [
                  Text(widget.notes!, style: AppTypography.bodyMedium),
                ],
              ),
              const SizedBox(height: AppSpacing.spaceMd),
            ],

            // Order Items
            _SectionCard(
              title: l10n.items,
              child: Column(
                children: [
                  ...widget.cartItems.map(
                    (item) => Padding(
                      padding: const EdgeInsets.only(
                        bottom: AppSpacing.spaceSm,
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color:
                                  item.product.backgroundColor ??
                                  AppColors.background,
                              borderRadius: BorderRadius.circular(
                                AppRadius.radiusSm,
                              ),
                            ),
                            child: item.product.imageUrl != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                      AppRadius.radiusSm,
                                    ),
                                    child: Image.network(
                                      item.product.imageUrl!,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              const Icon(
                                                Icons.image_outlined,
                                                color: AppColors.textSecondary,
                                              ),
                                    ),
                                  )
                                : Icon(
                                    Icons.inventory_2_outlined,
                                    color: AppColors.textSecondary.withValues(
                                      alpha: 0.5,
                                    ),
                                  ),
                          ),
                          const SizedBox(width: AppSpacing.spaceMd),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.product.name,
                                  style: AppTypography.bodyMedium.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  'Qty: ${item.quantity}',
                                  style: AppTypography.bodySmall.copyWith(
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            '\$${item.total.toStringAsFixed(2)}',
                            style: AppTypography.bodyMedium.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Divider(height: AppSpacing.spaceMd),

                  // Price breakdown
                  _SummaryRow(
                    label: l10n.subtotal,
                    value: '\$${widget.subtotal.toStringAsFixed(2)}',
                  ),
                  const SizedBox(height: AppSpacing.spaceXs),
                  _SummaryRow(
                    label: l10n.tax,
                    value: '\$${widget.tax.toStringAsFixed(2)}',
                  ),
                  const Divider(height: AppSpacing.spaceMd),
                  _SummaryRow(
                    label: l10n.total,
                    value: '\$${widget.total.toStringAsFixed(2)}',
                    isTotal: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(AppSpacing.paddingMd),
        decoration: BoxDecoration(
          color: AppColors.surface,
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          child: _isProcessing
              ? const Center(child: CircularProgressIndicator())
              : SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: _onConfirmOrder,
                    style: AppButtonStyles.primaryButton,
                    child: Text(l10n.confirmOrder),
                  ),
                ),
        ),
      ),
    );
  }

  Widget _buildSuccessScreen(AppLocalizations l10n) {
    final estimatedDeliveryDate = DateTime.now().add(const Duration(days: 3));
    final formattedDate =
        '${estimatedDeliveryDate.day} ${_getMonthName(estimatedDeliveryDate.month)}, ${estimatedDeliveryDate.year}';

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.paddingLg),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Success icon
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: AppColors.success.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_circle,
                  color: AppColors.success,
                  size: 60,
                ),
              ),
              const SizedBox(height: AppSpacing.spaceLg),

              // Success message
              Text(
                l10n.orderPlacedSuccess,
                style: AppTypography.h4.copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.spaceMd),
              Text(
                l10n.thankYouForOrder,
                style: AppTypography.bodyLarge.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.spaceXl),

              // Order details card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppSpacing.paddingLg),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(AppRadius.cardRadius),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.shadow,
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Order number
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          l10n.orderNumber,
                          style: AppTypography.bodyMedium.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                        Text(
                          _orderNumber,
                          style: AppTypography.bodyMedium.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.spaceMd),

                    // Estimated delivery
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          l10n.estimatedDelivery,
                          style: AppTypography.bodyMedium.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                        Text(
                          formattedDate,
                          style: AppTypography.bodyMedium.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.spaceMd),

                    // Total amount
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(l10n.total, style: AppTypography.h6),
                        Text(
                          '\$${widget.total.toStringAsFixed(2)}',
                          style: AppTypography.h6.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.spaceXl),

              // Action buttons
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: _onViewOrder,
                  style: AppButtonStyles.primaryButton,
                  child: Text(l10n.viewOrder),
                ),
              ),
              const SizedBox(height: AppSpacing.spaceMd),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: OutlinedButton(
                  onPressed: _onBackToHome,
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.primary),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        AppRadius.buttonRadius,
                      ),
                    ),
                  ),
                  child: Text(
                    l10n.backToHome,
                    style: const TextStyle(color: AppColors.primary),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getPaymentMethodName() {
    final l10n = AppLocalizations.of(context)!;
    switch (widget.paymentMethod) {
      case 'cash':
        return l10n.cashOnDelivery;
      case 'card':
        return l10n.creditCard;
      case 'bank':
        return l10n.bankTransfer;
      default:
        return widget.paymentMethod;
    }
  }

  String _getMonthName(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[month - 1];
  }

  void _onConfirmOrder() async {
    setState(() {
      _isProcessing = true;
    });

    // Simulate order processing
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      setState(() {
        _isProcessing = false;
        _orderPlaced = true;
      });
    }
  }

  void _onViewOrder() {
    // Navigate to order details
    // Pop all the way back to cart/home with success result
    Navigator.of(context).popUntil((route) => route.isFirst);
    // Could pass order data here if needed
  }

  void _onBackToHome() {
    // Pop all screens and return to home with success
    Navigator.of(context).popUntil((route) => route.isFirst);
  }
}

/// Info card widget
class _InfoCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Widget> children;

  const _InfoCard({
    required this.title,
    required this.icon,
    required this.children,
  });

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
            color: AppColors.shadow,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 20, color: AppColors.primary),
              const SizedBox(width: AppSpacing.spaceSm),
              Text(
                title,
                style: AppTypography.labelLarge.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.spaceSm),
          ...children,
        ],
      ),
    );
  }
}

/// Section card wrapper
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
            color: AppColors.shadow,
            blurRadius: 4,
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
              ? AppTypography.h6
              : AppTypography.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
        ),
        Text(
          value,
          style: isTotal
              ? AppTypography.h6.copyWith(color: AppColors.primary)
              : AppTypography.bodyMedium.copyWith(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
