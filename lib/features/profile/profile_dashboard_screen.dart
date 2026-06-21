import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_constants.dart';
import '../authentication/auth_bloc.dart';

class ProfileDashboardScreen extends StatelessWidget {
  const ProfileDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.containerMargin),
        child: Column(
          children: [
            const SizedBox(height: 40),
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: theme.colorScheme.primary,
                    child: Icon(Icons.person, size: 80, color: theme.colorScheme.onPrimary),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary,
                        shape: BoxShape.circle,
                        border: Border.all(color: theme.colorScheme.surface, width: 3),
                      ),
                      child: const Icon(Icons.edit, size: 20, color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text('John Doe', style: theme.textTheme.headlineLarge),
            Text('john.doe@example.com', style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
            const SizedBox(height: 32),
            _ProfileMenuItem(
              icon: Icons.person_outline,
              title: 'Account Settings',
              onTap: () => context.push('/account-settings'),
            ),
            _ProfileMenuItem(
              icon: Icons.shopping_bag_outlined,
              title: 'My Orders',
              onTap: () => context.push('/orders'),
            ),
            _ProfileMenuItem(
              icon: Icons.location_on_outline,
              title: 'Shipping Addresses',
              onTap: () => context.push('/address-selection'),
            ),
            _ProfileMenuItem(
              icon: Icons.notifications_none,
              title: 'Notifications',
              onTap: () => context.push('/notifications'),
            ),
            _ProfileMenuItem(
              icon: Icons.help_outline,
              title: 'Help & Support',
              onTap: () => context.push('/help-support'),
            ),
            const SizedBox(height: 32),
            _ProfileMenuItem(
              icon: Icons.logout,
              title: 'Logout',
              isDestructive: true,
              onTap: () {
                context.read<AuthBloc>().add(AuthLoggedOut());
                context.go('/gateway');
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool isDestructive;

  const _ProfileMenuItem({
    required this.icon,
    required this.title,
    required this.onTap,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = isDestructive ? Colors.red : theme.colorScheme.onSurface;

    return ListTile(
      onTap: onTap,
      leading: Icon(icon, color: color),
      title: Text(title, style: theme.textTheme.bodyLarge?.copyWith(color: color)),
      trailing: isDestructive ? null : Icon(Icons.chevron_right, color: theme.colorScheme.onSurfaceVariant, size: 20),
      contentPadding: EdgeInsets.zero,
    );
  }
}
