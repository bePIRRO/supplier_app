import 'package:flutter/material.dart';
import '../design/design_system.dart';
import '../widgets/app_loader.dart';
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
        const SnackBar(
          content: Text('Login successful!'),
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
      const SnackBar(
        content: Text('Forgot password functionality coming soon!'),
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
              const Center(child: Text('Logo', style: AppTypography.logoText)),

              const SizedBox(height: AppSpacing.space2xl),

              // Welcome Back Header
              const Text(
                'Welcome Back',
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
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: AppInputStyles.primaryInput.copyWith(
                        hintText: 'Email address',
                        prefixIcon: const Icon(
                          Icons.email_outlined,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      style: AppTypography.inputText,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email address';
                        }
                        if (!RegExp(
                          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                        ).hasMatch(value)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: AppSpacing.spaceMd),

                    // Password Field
                    TextFormField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      decoration: AppInputStyles.primaryInput.copyWith(
                        hintText: 'Password',
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
                          return 'Please enter your password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
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
                            : const Text('Login'),
                      ),
                    ),

                    const SizedBox(height: AppSpacing.spaceMd),

                    // Forgot Password Link
                    Center(
                      child: TextButton(
                        onPressed: _handleForgotPassword,
                        style: AppButtonStyles.textButton,
                        child: const Text(
                          'Forgot password?',
                          style: AppTypography.link,
                        ),
                      ),
                    ),

                    const SizedBox(height: AppSpacing.spaceLg),

                    // Sign Up Link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account? ",
                          style: AppTypography.bodyMedium,
                        ),
                        TextButton(
                          onPressed: _navigateToSignUp,
                          style: AppButtonStyles.textButton.copyWith(
                            padding: MaterialStateProperty.all(
                              const EdgeInsets.symmetric(
                                horizontal: AppSpacing.paddingXs,
                                vertical: AppSpacing.paddingXs,
                              ),
                            ),
                          ),
                          child: const Text(
                            'Sign up',
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
