import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../design/design_system.dart';

/// Profile screen for the Supplier App
/// Displays user information, settings, and account options
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        title: Text(l10n.myProfile, style: AppTypography.h5),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => _onEditProfile(context),
            icon: const Icon(Icons.edit_outlined, color: AppColors.primary),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Header
            _ProfileHeader(),
            const SizedBox(height: AppSpacing.spaceMd),

            // Personal Information Section
            _Section(
              title: l10n.personalInformation,
              children: [
                _InfoTile(
                  icon: Icons.email_outlined,
                  label: l10n.emailAddress,
                  value: 'supplier@example.com',
                ),
                _InfoTile(
                  icon: Icons.phone_outlined,
                  label: l10n.phoneNumber,
                  value: '+1 (555) 123-4567',
                ),
                _InfoTile(
                  icon: Icons.location_on_outlined,
                  label: l10n.address,
                  value: '123 Main Street, New York, NY 10001',
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.spaceMd),

            // Business Information Section
            _Section(
              title: l10n.businessInformation,
              children: [
                _InfoTile(
                  icon: Icons.business_outlined,
                  label: l10n.companyName,
                  value: 'Fresh Foods Inc.',
                ),
                _InfoTile(
                  icon: Icons.badge_outlined,
                  label: 'Business ID',
                  value: 'SUP-2024-001',
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.spaceMd),

            // Settings Section
            _Section(
              title: l10n.settings,
              children: [
                _ActionTile(
                  icon: Icons.language_outlined,
                  title: l10n.language,
                  trailing: Text(
                    l10n.english,
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  onTap: () => _onLanguageSettings(context),
                ),
                _ActionTile(
                  icon: Icons.palette_outlined,
                  title: l10n.theme,
                  trailing: Text(
                    l10n.system,
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  onTap: () => _onThemeSettings(context),
                ),
                _SwitchTile(
                  icon: Icons.notifications_outlined,
                  title: l10n.notifications,
                  value: true,
                  onChanged: (value) => _onNotificationsToggle(context, value),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.spaceMd),

            // Support Section
            _Section(
              title: l10n.support,
              children: [
                _ActionTile(
                  icon: Icons.help_outline,
                  title: l10n.helpCenter,
                  onTap: () => _onHelpCenter(context),
                ),
                _ActionTile(
                  icon: Icons.support_agent_outlined,
                  title: l10n.contactSupport,
                  onTap: () => _onContactSupport(context),
                ),
                _ActionTile(
                  icon: Icons.article_outlined,
                  title: l10n.termsOfService,
                  onTap: () => _onTermsOfService(context),
                ),
                _ActionTile(
                  icon: Icons.privacy_tip_outlined,
                  title: l10n.privacyPolicy,
                  onTap: () => _onPrivacyPolicy(context),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.spaceMd),

            // About Section
            _Section(
              title: l10n.aboutApp,
              children: [
                _InfoTile(
                  icon: Icons.info_outlined,
                  label: l10n.version,
                  value: '1.0.0',
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.spaceMd),

            // Logout Button
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.paddingMd,
              ),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: OutlinedButton(
                  onPressed: () => _onLogout(context),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.error),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        AppRadius.buttonRadius,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.logout, color: AppColors.error),
                      const SizedBox(width: AppSpacing.spaceSm),
                      Text(
                        l10n.logout,
                        style: const TextStyle(color: AppColors.error),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.spaceLg),
          ],
        ),
      ),
    );
  }

  void _onEditProfile(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${l10n.editProfile} - Coming soon!')),
    );
  }

  void _onLanguageSettings(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${l10n.language} settings - Coming soon!')),
    );
  }

  void _onThemeSettings(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${l10n.theme} settings - Coming soon!')),
    );
  }

  void _onNotificationsToggle(BuildContext context, bool value) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Notifications ${value ? "enabled" : "disabled"}'),
      ),
    );
  }

  void _onHelpCenter(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${l10n.helpCenter} - Coming soon!')),
    );
  }

  void _onContactSupport(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${l10n.contactSupport} - Coming soon!')),
    );
  }

  void _onTermsOfService(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${l10n.termsOfService} - Coming soon!')),
    );
  }

  void _onPrivacyPolicy(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${l10n.privacyPolicy} - Coming soon!')),
    );
  }

  void _onLogout(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.logout),
        content: Text(l10n.confirmLogout),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${l10n.logout} - Coming soon!')),
              );
            },
            child: Text(
              l10n.logout,
              style: const TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
  }
}

/// Profile header widget with avatar and name
class _ProfileHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.paddingLg),
      decoration: const BoxDecoration(color: AppColors.surface),
      child: Column(
        children: [
          // Avatar
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primary.withValues(alpha: 0.1),
              border: Border.all(color: AppColors.primary, width: 3),
            ),
            child: const Icon(Icons.person, size: 50, color: AppColors.primary),
          ),
          const SizedBox(height: AppSpacing.spaceMd),

          // Name
          Text(
            'John Supplier',
            style: AppTypography.h4.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: AppSpacing.spaceXs),

          // Email
          Text(
            'supplier@example.com',
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

/// Section container widget
class _Section extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _Section({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.paddingMd),
          child: Text(
            title,
            style: AppTypography.labelLarge.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.spaceSm),
        Container(
          color: AppColors.surface,
          child: Column(children: children),
        ),
      ],
    );
  }
}

/// Info tile widget for displaying information
class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoTile({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.paddingMd,
        vertical: AppSpacing.paddingSm,
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.textSecondary, size: 24),
          const SizedBox(width: AppSpacing.spaceMd),
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
      ),
    );
  }
}

/// Action tile widget for tappable options
class _ActionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget? trailing;
  final VoidCallback onTap;

  const _ActionTile({
    required this.icon,
    required this.title,
    this.trailing,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.paddingMd,
          vertical: AppSpacing.paddingSm,
        ),
        child: Row(
          children: [
            Icon(icon, color: AppColors.textSecondary, size: 24),
            const SizedBox(width: AppSpacing.spaceMd),
            Expanded(child: Text(title, style: AppTypography.bodyMedium)),
            if (trailing != null)
              trailing!
            else
              const Icon(Icons.chevron_right, color: AppColors.textSecondary),
          ],
        ),
      ),
    );
  }
}

/// Switch tile widget for toggle options
class _SwitchTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _SwitchTile({
    required this.icon,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.paddingMd,
        vertical: AppSpacing.paddingSm,
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.textSecondary, size: 24),
          const SizedBox(width: AppSpacing.spaceMd),
          Expanded(child: Text(title, style: AppTypography.bodyMedium)),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.primary,
          ),
        ],
      ),
    );
  }
}
