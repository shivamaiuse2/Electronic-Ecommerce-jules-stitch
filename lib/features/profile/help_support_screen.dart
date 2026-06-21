import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_constants.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Help & Support'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.containerMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppConstants.borderRadiusDefault),
                border: Border.all(color: theme.colorScheme.primary.withOpacity(0.2)),
              ),
              child: Column(
                children: [
                  const Icon(Icons.support_agent, size: 48, color: AppColors.primary),
                  const SizedBox(height: 16),
                  Text('How can we help you?', style: theme.textTheme.headlineMedium),
                  const SizedBox(height: 8),
                  Text(
                    'Our support team is available 24/7 to assist you with any questions or issues.',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodySmall,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () => context.push('/live-chat'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colorScheme.primary,
                      foregroundColor: theme.colorScheme.onPrimary,
                      minimumSize: const Size(double.infinity, 48),
                      shape: const StadiumBorder(),
                    ),
                    child: const Text('Start Live Chat'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            Text('Frequently Asked Questions', style: theme.textTheme.headlineSmall),
            const SizedBox(height: 16),
            _FaqItem(title: 'How do I track my order?'),
            _FaqItem(title: 'What is your return policy?'),
            _FaqItem(title: 'How can I change my shipping address?'),
            _FaqItem(title: 'Do you offer international shipping?'),
            _FaqItem(title: 'What payment methods do you accept?'),
          ],
        ),
      ),
    );
  }
}

class _FaqItem extends StatelessWidget {
  final String title;
  const _FaqItem({required this.title});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ExpansionTile(
      title: Text(title, style: theme.textTheme.bodyLarge),
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
            style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
          ),
        ),
      ],
    );
  }
}

class AppColors {
  static const Color primary = Color(0xFF5CDE94);
}
