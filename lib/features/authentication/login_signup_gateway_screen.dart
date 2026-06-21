import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_constants.dart';
import '../../shared/widgets/electro_button.dart';

class LoginSignupGatewayScreen extends StatelessWidget {
  const LoginSignupGatewayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Stack(
        children: [
          // Background with vibrant green accent
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppConstants.containerMargin),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    borderRadius: BorderRadius.circular(AppConstants.borderRadiusDefault),
                  ),
                  child: Icon(Icons.bolt, size: 48, color: theme.colorScheme.onPrimary),
                ),
                const SizedBox(height: 32),
                Text(
                  'Welcome to ElectroStream',
                  textAlign: Center,
                  style: theme.textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 12),
                Text(
                  'The ultimate destination for premium tech and gadgets.',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                ),
                const Spacer(),
                ElectroButton(
                  text: 'Login',
                  onPressed: () => context.go('/login'),
                ),
                const SizedBox(height: 16),
                ElectroButton(
                  text: 'Create Account',
                  backgroundColor: theme.colorScheme.surfaceVariant.withOpacity(0.3),
                  textColor: theme.colorScheme.onSurface,
                  onPressed: () => context.go('/signup'),
                ),
                const SizedBox(height: 32),
                Row(
                  children: [
                    Expanded(child: Divider(color: theme.colorScheme.outlineVariant.withOpacity(0.3))),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text('OR', style: theme.textTheme.labelMedium),
                    ),
                    Expanded(child: Divider(color: theme.colorScheme.outlineVariant.withOpacity(0.3))),
                  ],
                ),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _SocialButton(icon: Icons.g_mobiledata, onTap: () {}),
                    const SizedBox(width: 24),
                    _SocialButton(icon: Icons.apple, onTap: () {}),
                    const SizedBox(width: 24),
                    _SocialButton(icon: Icons.facebook, onTap: () {}),
                  ],
                ),
                const SizedBox(height: 48),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _SocialButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceVariant.withOpacity(0.3),
          shape: BoxShape.circle,
          border: Border.all(color: theme.colorScheme.outlineVariant.withOpacity(0.2)),
        ),
        child: Icon(icon, size: 28),
      ),
    );
  }
}
