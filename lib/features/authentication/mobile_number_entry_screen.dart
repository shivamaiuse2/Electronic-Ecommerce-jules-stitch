import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_constants.dart';
import '../../shared/widgets/electro_button.dart';
import '../../shared/widgets/electro_text_field.dart';

class MobileNumberEntryScreen extends StatelessWidget {
  const MobileNumberEntryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/signup'),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppConstants.containerMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text(
              'Verify Mobile',
              style: theme.textTheme.displayLarge?.copyWith(fontWeight: FontWeight.w800, fontSize: 32),
            ),
            const SizedBox(height: 8),
            Text(
              'We need to verify your mobile number for secure transactions.',
              style: theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.onSurfaceVariant),
            ),
            const SizedBox(height: 48),
            ElectroTextField(
              hintText: 'Mobile Number',
              keyboardType: TextInputType.phone,
              prefixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(width: 16),
                  Text('+1', style: theme.textTheme.bodyLarge),
                  const SizedBox(width: 8),
                  Container(width: 1, height: 24, color: theme.colorScheme.outlineVariant),
                  const SizedBox(width: 8),
                ],
              ),
            ),
            const Spacer(),
            ElectroButton(
              text: 'Send OTP',
              onPressed: () => context.go('/otp'),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
