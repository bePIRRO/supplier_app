import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../design/design_system.dart';
import 'signup_screen.dart';

/// Login screen for the Supplier App
/// Based on the design mockup with orange branding and clean form layout
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Simulate login process
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isLoading = false;
    });

    // TODO: Implement actual login logic
    // For now, just show a success message
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.loginSuccessful),
          backgroundColor: AppColors.success,
        ),
      );
    }
  }

  void _navigateToSignUp() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SignUpScreen()),
    );
  }

  void _handleForgotPassword() {
    // TODO: Implement forgot password functionality
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(AppLocalizations.of(context)!.forgotPasswordComingSoon),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.screenPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: AppSpacing.space3xl),

              // Logo Section
              Center(
                child: Text(
                  AppLocalizations.of(context)!.logo,
                  style: AppTypography.logoText,
                ),
              ),

              const SizedBox(height: AppSpacing.space2xl),

              // Welcome Back Header
              Text(
                AppLocalizations.of(context)!.welcomeBack,
                style: AppTypography.welcomeTitle,
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: AppSpacing.spaceXl),

              // Login Form
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
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
                              return l10n.pleaseEnterPassword;
                            }
                            if (value.length < 6) {
                              return l10n.passwordMinLength;
                            }
                            return null;
                          },
                        );
                      },
                    ),

                    const SizedBox(height: AppSpacing.spaceLg),

                    // Login Button
                    SizedBox(
                      height: AppSizes.buttonHeightMd,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _handleLogin,
                        style: AppButtonStyles.primaryButton,
                        child: _isLoading
                            ? const AppLoader.button()
                            : Text(AppLocalizations.of(context)!.login),
                      ),
                    ),

                    const SizedBox(height: AppSpacing.spaceMd),

                    // Forgot Password Link
                    Center(
                      child: TextButton(
                        onPressed: _handleForgotPassword,
                        style: AppButtonStyles.textButton,
                        child: Text(
                          AppLocalizations.of(context)!.forgotPassword,
                          style: AppTypography.link,
                        ),
                      ),
                    ),

                    const SizedBox(height: AppSpacing.spaceLg),

                    // Sign Up Link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.dontHaveAccount,
                          style: AppTypography.bodyMedium,
                        ),
                        TextButton(
                          onPressed: _navigateToSignUp,
                          style: AppButtonStyles.textButton.copyWith(
                            padding: WidgetStateProperty.all(
                              const EdgeInsets.symmetric(
                                horizontal: AppSpacing.paddingXs,
                                vertical: AppSpacing.paddingXs,
                              ),
                            ),
                          ),
                          child: Text(
                            AppLocalizations.of(context)!.signUp,
                            style: AppTypography.link,
                          ),
                        ),
                      ],
                    ),
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
