import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../../design/design_system.dart';
import '../../models/cart_item.dart';
import 'place_order_screen.dart';

/// Checkout screen for completing the order
class CheckoutScreen extends StatefulWidget {
  final List<CartItem> cartItems;
  final double subtotal;
  final double tax;
  final double total;

  const CheckoutScreen({
    super.key,
    required this.cartItems,
    required this.subtotal,
    required this.tax,
    required this.total,
  });

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();
  final _addressController = TextEditingController(text: '123 Main Street');
  final _cityController = TextEditingController(text: 'New York');
  final _stateController = TextEditingController(text: 'NY');
  final _zipCodeController = TextEditingController(text: '10001');
  final _phoneController = TextEditingController(text: '+1 (555) 123-4567');
  final _emailController = TextEditingController(text: 'supplier@example.com');
  final _notesController = TextEditingController();

  String _selectedPaymentMethod = 'cash';

  @override
  void dispose() {
    _addressController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _zipCodeController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _notesController.dispose();
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
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
        ),
        title: Text(l10n.checkoutTitle, style: AppTypography.h5),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppSpacing.paddingMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Delivery Information Section
                    _SectionCard(
                      title: l10n.deliveryInformation,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _addressController,
                            decoration: AppInputStyles.primaryInput.copyWith(
                              hintText: l10n.address,
                              prefixIcon: const Icon(
                                Icons.location_on_outlined,
                                color: AppColors.textSecondary,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return l10n.pleaseEnterAddress;
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: AppSpacing.spaceMd),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: _cityController,
                                  decoration: AppInputStyles.primaryInput
                                      .copyWith(hintText: l10n.city),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return l10n.pleaseEnterCity;
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(width: AppSpacing.spaceMd),
                              Expanded(
                                child: TextFormField(
                                  controller: _stateController,
                                  decoration: AppInputStyles.primaryInput
                                      .copyWith(hintText: l10n.state),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return l10n.pleaseEnterState;
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: AppSpacing.spaceMd),
                          TextFormField(
                            controller: _zipCodeController,
                            keyboardType: TextInputType.number,
                            decoration: AppInputStyles.primaryInput.copyWith(
                              hintText: l10n.zipCode,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return l10n.pleaseEnterZipCode;
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.spaceMd),

                    // Contact Information Section
                    _SectionCard(
                      title: l10n.contactInformation,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _phoneController,
                            keyboardType: TextInputType.phone,
                            decoration: AppInputStyles.primaryInput.copyWith(
                              hintText: l10n.phoneNumber,
                              prefixIcon: const Icon(
                                Icons.phone_outlined,
                                color: AppColors.textSecondary,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return l10n.pleaseEnterPhoneNumber;
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: AppSpacing.spaceMd),
                          TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: AppInputStyles.primaryInput.copyWith(
                              hintText: l10n.emailAddress,
                              prefixIcon: const Icon(
                                Icons.email_outlined,
                                color: AppColors.textSecondary,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return l10n.pleaseEnterEmail;
                              }
                              if (!value.contains('@')) {
                                return l10n.pleaseEnterValidEmail;
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.spaceMd),

                    // Payment Method Section
                    _SectionCard(
                      title: l10n.paymentMethod,
                      child: Column(
                        children: [
                          _PaymentMethodOption(
                            value: 'cash',
                            groupValue: _selectedPaymentMethod,
                            title: l10n.cashOnDelivery,
                            icon: Icons.money,
                            onChanged: (value) {
                              setState(() {
                                _selectedPaymentMethod = value!;
                              });
                            },
                          ),
                          const SizedBox(height: AppSpacing.spaceSm),
                          _PaymentMethodOption(
                            value: 'card',
                            groupValue: _selectedPaymentMethod,
                            title: l10n.creditCard,
                            icon: Icons.credit_card,
                            onChanged: (value) {
                              setState(() {
                                _selectedPaymentMethod = value!;
                              });
                            },
                          ),
                          const SizedBox(height: AppSpacing.spaceSm),
                          _PaymentMethodOption(
                            value: 'bank',
                            groupValue: _selectedPaymentMethod,
                            title: l10n.bankTransfer,
                            icon: Icons.account_balance,
                            onChanged: (value) {
                              setState(() {
                                _selectedPaymentMethod = value!;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.spaceMd),

                    // Delivery Notes Section
                    _SectionCard(
                      title: l10n.deliveryNotes,
                      child: TextFormField(
                        controller: _notesController,
                        maxLines: 3,
                        decoration: AppInputStyles.primaryInput.copyWith(
                          hintText: l10n.notes,
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.spaceMd),

                    // Order Summary Section
                    _SectionCard(
                      title: l10n.orderSummaryTitle,
                      child: Column(
                        children: [
                          // Items list
                          ...widget.cartItems.map(
                            (item) => Padding(
                              padding: const EdgeInsets.only(
                                bottom: AppSpacing.spaceSm,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      '${item.product.name} x${item.quantity}',
                                      style: AppTypography.bodyMedium,
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
            ),

            // Place Order Button
            Container(
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
                child: SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: _onPlaceOrder,
                    style: AppButtonStyles.primaryButton,
                    child: Text(l10n.placeOrder),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onPlaceOrder() {
    if (_formKey.currentState!.validate()) {
      // Navigate to place order screen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PlaceOrderScreen(
            cartItems: widget.cartItems,
            subtotal: widget.subtotal,
            tax: widget.tax,
            total: widget.total,
            address: _addressController.text,
            city: _cityController.text,
            state: _stateController.text,
            zipCode: _zipCodeController.text,
            phone: _phoneController.text,
            email: _emailController.text,
            paymentMethod: _selectedPaymentMethod,
            notes: _notesController.text.isEmpty ? null : _notesController.text,
          ),
        ),
      ).then((result) {
        // If order was placed successfully, return to cart
        if (result == true && mounted) {
          Navigator.pop(context, true);
        }
      });
    }
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

/// Payment method option widget
class _PaymentMethodOption extends StatelessWidget {
  final String value;
  final String groupValue;
  final String title;
  final IconData icon;
  final ValueChanged<String?> onChanged;

  const _PaymentMethodOption({
    required this.value,
    required this.groupValue,
    required this.title,
    required this.icon,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = value == groupValue;

    return InkWell(
      onTap: () => onChanged(value),
      borderRadius: BorderRadius.circular(AppRadius.radiusMd),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.paddingMd),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(AppRadius.radiusMd),
          color: isSelected
              ? AppColors.primary.withValues(alpha: 0.05)
              : Colors.transparent,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? AppColors.primary : AppColors.textSecondary,
            ),
            const SizedBox(width: AppSpacing.spaceMd),
            Expanded(
              child: Text(
                title,
                style: AppTypography.bodyMedium.copyWith(
                  color: isSelected ? AppColors.primary : AppColors.textPrimary,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ),
            Radio<String>(
              value: value,
              groupValue: groupValue,
              onChanged: onChanged,
              activeColor: AppColors.primary,
            ),
          ],
        ),
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
