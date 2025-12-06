import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../design/design_system.dart';
import '../models/cart_item.dart';
import '../data/cart_data.dart';
import 'checkout/checkout_screen.dart';

/// Cart screen for the Supplier App
/// Displays shopping cart with items, quantities, and checkout
class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<CartItem> _cartItems = [];

  @override
  void initState() {
    super.initState();
    _cartItems = List.from(CartData.sampleCartItems);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final subtotal = CartData.calculateSubtotal(_cartItems);
    final tax = CartData.calculateTax(subtotal);
    final total = subtotal + tax;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        title: Text(l10n.myCart, style: AppTypography.h5),
        centerTitle: true,
        actions: [
          if (_cartItems.isNotEmpty)
            IconButton(
              onPressed: _onClearCart,
              icon: const Icon(Icons.delete_outline, color: AppColors.error),
            ),
        ],
      ),
      body: _cartItems.isEmpty ? _buildEmptyCart() : _buildCartContent(),
      bottomNavigationBar: _cartItems.isEmpty
          ? null
          : _buildCheckoutSection(subtotal, tax, total),
    );
  }

  Widget _buildEmptyCart() {
    final l10n = AppLocalizations.of(context)!;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.screenPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_cart_outlined,
              size: 120,
              color: AppColors.textSecondary.withValues(alpha: 0.3),
            ),
            const SizedBox(height: AppSpacing.spaceLg),
            Text(
              l10n.emptyCart,
              style: AppTypography.h5.copyWith(color: AppColors.textSecondary),
            ),
            const SizedBox(height: AppSpacing.spaceSm),
            Text(
              l10n.emptyCartMessage,
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.spaceLg),
            ElevatedButton(
              onPressed: _onStartShopping,
              style: AppButtonStyles.primaryButton,
              child: Text(l10n.startShopping),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCartContent() {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      children: [
        // Items count header
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(AppSpacing.paddingMd),
          color: AppColors.surface,
          child: Text(
            l10n.itemsInCart(_cartItems.length),
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ),

        // Cart items list
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.all(AppSpacing.screenPadding),
            itemCount: _cartItems.length,
            separatorBuilder: (context, index) =>
                const SizedBox(height: AppSpacing.spaceMd),
            itemBuilder: (context, index) {
              return _CartItemCard(
                cartItem: _cartItems[index],
                onQuantityChanged: (newQuantity) =>
                    _onQuantityChanged(index, newQuantity),
                onRemove: () => _onRemoveItem(index),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCheckoutSection(double subtotal, double tax, double total) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
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
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.paddingMd),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Subtotal
              _SummaryRow(
                label: l10n.subtotal,
                value: '\$${subtotal.toStringAsFixed(2)}',
              ),
              const SizedBox(height: AppSpacing.spaceXs),

              // Tax
              _SummaryRow(
                label: l10n.tax,
                value: '\$${tax.toStringAsFixed(2)}',
              ),
              const Divider(height: AppSpacing.spaceMd),

              // Total
              _SummaryRow(
                label: l10n.total,
                value: '\$${total.toStringAsFixed(2)}',
                isTotal: true,
              ),
              const SizedBox(height: AppSpacing.spaceMd),

              // Checkout button
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: _onCheckout,
                  style: AppButtonStyles.primaryButton,
                  child: Text(l10n.checkout),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onQuantityChanged(int index, int newQuantity) {
    if (newQuantity <= 0) {
      _onRemoveItem(index);
      return;
    }

    setState(() {
      _cartItems[index] = _cartItems[index].copyWith(quantity: newQuantity);
    });
  }

  void _onRemoveItem(int index) {
    setState(() {
      _cartItems.removeAt(index);
    });
  }

  void _onClearCart() {
    final l10n = AppLocalizations.of(context)!;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.clearCart),
        content: Text(l10n.confirmClearCart),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _cartItems.clear();
              });
              Navigator.pop(context);
            },
            child: Text(
              l10n.clearCart,
              style: const TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
  }

  void _onCheckout() async {
    final subtotal = CartData.calculateSubtotal(_cartItems);
    final tax = CartData.calculateTax(subtotal);
    final total = subtotal + tax;

    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CheckoutScreen(
          cartItems: _cartItems,
          subtotal: subtotal,
          tax: tax,
          total: total,
        ),
      ),
    );

    // If checkout was successful, clear the cart
    if (result == true && mounted) {
      setState(() {
        _cartItems.clear();
      });
    }
  }

  void _onStartShopping() {
    // Navigate to home screen (first tab)
    // This will be handled by the main navigation
  }
}

/// Cart item card widget
class _CartItemCard extends StatelessWidget {
  final CartItem cartItem;
  final Function(int) onQuantityChanged;
  final VoidCallback onRemove;

  const _CartItemCard({
    required this.cartItem,
    required this.onQuantityChanged,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final product = cartItem.product;

    return Container(
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
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.paddingMd),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product image
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: product.backgroundColor ?? AppColors.background,
                borderRadius: BorderRadius.circular(AppRadius.radiusMd),
              ),
              child: product.imageUrl != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(AppRadius.radiusMd),
                      child: Image.network(
                        product.imageUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(
                              Icons.image_outlined,
                              color: AppColors.textSecondary,
                            ),
                      ),
                    )
                  : Icon(
                      Icons.inventory_2_outlined,
                      color: AppColors.textSecondary.withValues(alpha: 0.5),
                      size: 32,
                    ),
            ),
            const SizedBox(width: AppSpacing.spaceMd),

            // Product info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: AppTypography.bodyLarge.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.spaceXs),
                  Text(
                    product.price ?? '',
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.spaceSm),

                  // Quantity controls
                  Row(
                    children: [
                      // Decrease button
                      _QuantityButton(
                        icon: Icons.remove,
                        onPressed: () =>
                            onQuantityChanged(cartItem.quantity - 1),
                      ),
                      const SizedBox(width: AppSpacing.spaceSm),

                      // Quantity display
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.paddingMd,
                          vertical: AppSpacing.paddingXs,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.background,
                          borderRadius: BorderRadius.circular(
                            AppRadius.radiusSm,
                          ),
                        ),
                        child: Text(
                          '${cartItem.quantity}',
                          style: AppTypography.bodyMedium.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.spaceSm),

                      // Increase button
                      _QuantityButton(
                        icon: Icons.add,
                        onPressed: () =>
                            onQuantityChanged(cartItem.quantity + 1),
                      ),
                      const Spacer(),

                      // Remove button
                      IconButton(
                        onPressed: onRemove,
                        icon: const Icon(
                          Icons.delete_outline,
                          color: AppColors.error,
                        ),
                        tooltip: l10n.remove,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Quantity control button
class _QuantityButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const _QuantityButton({required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(AppRadius.radiusSm),
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        onPressed: onPressed,
        icon: Icon(icon, color: Colors.white, size: 20),
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
