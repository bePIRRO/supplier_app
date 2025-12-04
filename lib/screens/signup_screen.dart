import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../design/design_system.dart';

/// Sign up screen for the Supplier App
/// Allows new users to create an account with form validation
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _companyController = TextEditingController();
  final _phoneController = TextEditingController();

  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _agreeToTerms = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _companyController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _handleSignUp() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (!_agreeToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.pleaseAgreeToTerms),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Simulate sign up process
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isLoading = false;
    });

    // TODO: Implement actual sign up logic
    // For now, just show a success message and navigate back
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            AppLocalizations.of(context)!.accountCreatedSuccessfully,
          ),
          backgroundColor: AppColors.success,
        ),
      );

      // Navigate back to login
      Navigator.pop(context);
    }
  }

  void _navigateToLogin() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: _navigateToLogin,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.screenPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: AppSpacing.spaceLg),

              // Logo Section
              Center(
                child: Text(
                  AppLocalizations.of(context)!.logo,
                  style: AppTypography.logoText,
                ),
              ),

              const SizedBox(height: AppSpacing.spaceXl),

              // Create Account Header
              Text(
                AppLocalizations.of(context)!.createAccount,
                style: AppTypography.welcomeTitle,
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: AppSpacing.paddingSm),

              Text(
                AppLocalizations.of(context)!.joinSupplierNetwork,
                style: AppTypography.bodyMedium,
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: AppSpacing.spaceXl),

              // Sign Up Form
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Full Name Field
                    Builder(
                      builder: (context) {
                        final l10n = AppLocalizations.of(context)!;
                        return TextFormField(
                          controller: _nameController,
                          keyboardType: TextInputType.name,
                          textCapitalization: TextCapitalization.words,
                          decoration: AppInputStyles.primaryInput.copyWith(
                            hintText: l10n.fullName,
                            prefixIcon: const Icon(
                              Icons.person_outline,
                              color: AppColors.textSecondary,
                            ),
                          ),
                          style: AppTypography.inputText,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return l10n.pleaseEnterFullName;
                            }
                            if (value.trim().split(' ').length < 2) {
                              return l10n.pleaseEnterFirstLastName;
                            }
                            return null;
                          },
                        );
                      },
                    ),

                    const SizedBox(height: AppSpacing.spaceMd),

                    // Email Field
                    Builder(
                      builder: (context) {
                        final l10n = AppLocalizations.of(context)!;
                        return TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: AppInputStyles.primaryInput.copyWith(
                            hintText: l10n.emailAddress,
                            prefixIcon: const Icon(
                              Icons.email_outlined,
                              color: AppColors.textSecondary,
                            ),
                          ),
                          style: AppTypography.inputText,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return l10n.pleaseEnterEmail;
                            }
                            if (!RegExp(
                              r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                            ).hasMatch(value)) {
                              return l10n.pleaseEnterValidEmail;
                            }
                            return null;
                          },
                        );
                      },
                    ),

                    const SizedBox(height: AppSpacing.spaceMd),

                    // Company Name Field
                    Builder(
                      builder: (context) {
                        final l10n = AppLocalizations.of(context)!;
                        return TextFormField(
                          controller: _companyController,
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.words,
                          decoration: AppInputStyles.primaryInput.copyWith(
                            hintText: l10n.companyName,
                            prefixIcon: const Icon(
                              Icons.business_outlined,
                              color: AppColors.textSecondary,
                            ),
                          ),
                          style: AppTypography.inputText,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return l10n.pleaseEnterCompanyName;
                            }
                            return null;
                          },
                        );
                      },
                    ),

                    const SizedBox(height: AppSpacing.spaceMd),

                    // Phone Number Field
                    Builder(
                      builder: (context) {
                        final l10n = AppLocalizations.of(context)!;
                        return TextFormField(
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          decoration: AppInputStyles.primaryInput.copyWith(
                            hintText: l10n.phoneNumber,
                            prefixIcon: const Icon(
                              Icons.phone_outlined,
                              color: AppColors.textSecondary,
                            ),
                          ),
                          style: AppTypography.inputText,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return l10n.pleaseEnterPhoneNumber;
                            }
                            if (value.length < 10) {
                              return l10n.pleaseEnterValidPhoneNumber;
                            }
                            return null;
                          },
                        );
                      },
                    ),

                    const SizedBox(height: AppSpacing.spaceMd),

                    // Password Field
                    Builder(
                      builder: (context) {
                        final l10n = AppLocalizations.of(context)!;
                        return TextFormField(
                          controller: _passwordController,
                          obscureText: _obscurePassword,
                          decoration: AppInputStyles.primaryInput.copyWith(
                            hintText: l10n.password,
                            prefixIcon: const Icon(
                              Icons.lock_outline,
                              color: AppColors.textSecondary,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                                color: AppColors.textSecondary,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                            ),
                          ),
                          style: AppTypography.inputText,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return l10n.pleaseEnterAPassword;
                            }
                            if (value.length < 8) {
                              return l10n.passwordMinLengthEight;
                            }
                            if (!RegExp(
                              r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)',
                            ).hasMatch(value)) {
                              return l10n.passwordRequirements;
                            }
                            return null;
                          },
                        );
                      },
                    ),

                    const SizedBox(height: AppSpacing.spaceMd),

                    // Confirm Password Field
                    Builder(
                      builder: (context) {
                        final l10n = AppLocalizations.of(context)!;
                        return TextFormField(
                          controller: _confirmPasswordController,
                          obscureText: _obscureConfirmPassword,
                          decoration: AppInputStyles.primaryInput.copyWith(
                            hintText: l10n.confirmPassword,
                            prefixIcon: const Icon(
                              Icons.lock_outline,
                              color: AppColors.textSecondary,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureConfirmPassword
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                                color: AppColors.textSecondary,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscureConfirmPassword =
                                      !_obscureConfirmPassword;
                                });
                              },
                            ),
                          ),
                          style: AppTypography.inputText,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return l10n.pleaseConfirmPassword;
                            }
                            if (value != _passwordController.text) {
                              return l10n.passwordsDoNotMatch;
                            }
                            return null;
                          },
                        );
                      },
                    ),

                    const SizedBox(height: AppSpacing.spaceMd),

                    // Terms and Conditions Checkbox
                    Builder(
                      builder: (context) {
                        final l10n = AppLocalizations.of(context)!;
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Checkbox(
                              value: _agreeToTerms,
                              onChanged: (value) {
                                setState(() {
                                  _agreeToTerms = value ?? false;
                                });
                              },
                              fillColor: WidgetStateProperty.resolveWith((
                                states,
                              ) {
                                if (states.contains(WidgetState.selected)) {
                                  return AppColors.primary;
                                }
                                return AppColors.grey300;
                              }),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 12),
                                child: RichText(
                                  text: TextSpan(
                                    style: AppTypography.bodySmall,
                                    children: [
                                      TextSpan(text: l10n.iAgreeToThe),
                                      TextSpan(
                                        text: l10n.termsAndConditions,
                                        style: AppTypography.link.copyWith(
                                          fontSize: 12,
                                        ),
                                      ),
                                      TextSpan(text: l10n.and),
                                      TextSpan(
                                        text: l10n.privacyPolicy,
                                        style: AppTypography.link.copyWith(
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),

                    const SizedBox(height: AppSpacing.spaceLg),

                    // Sign Up Button
                    SizedBox(
                      height: AppSizes.buttonHeightMd,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _handleSignUp,
                        style: AppButtonStyles.primaryButton,
                        child: _isLoading
                            ? const AppLoader.button()
                            : Text(AppLocalizations.of(context)!.createAccount),
                      ),
                    ),

                    const SizedBox(height: AppSpacing.spaceLg),

                    // Login Link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.alreadyHaveAccount,
                          style: AppTypography.bodyMedium,
                        ),
                        TextButton(
                          onPressed: _navigateToLogin,
                          style: AppButtonStyles.textButton.copyWith(
                            padding: WidgetStateProperty.all(
                              const EdgeInsets.symmetric(
                                horizontal: AppSpacing.paddingXs,
                                vertical: AppSpacing.paddingXs,
                              ),
                            ),
                          ),
                          child: Text(
                            AppLocalizations.of(context)!.signIn,
                            style: AppTypography.link,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: AppSpacing.spaceLg),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
