import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_constants.dart';
import '../../shared/widgets/electro_button.dart';
import '../../shared/widgets/electro_text_field.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/gateway'),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.containerMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text(
              'Join the Stream',
              style: theme.textTheme.displayLarge?.copyWith(fontWeight: FontWeight.w800, fontSize: 32),
            ),
            const SizedBox(height: 8),
            Text(
              'Create an account to start your premium tech journey.',
              style: theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.onSurfaceVariant),
            ),
            const SizedBox(height: 40),
            const ElectroTextField(
              hintText: 'Full Name',
              prefixIcon: Icon(Icons.person_outline),
            ),
            const SizedBox(height: 16),
            const ElectroTextField(
              hintText: 'Email Address',
              prefixIcon: Icon(Icons.email_outlined),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            const ElectroTextField(
              hintText: 'Password',
              prefixIcon: Icon(Icons.lock_outline),
              isPassword: true,
              suffixIcon: Icon(Icons.visibility_off_outlined),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                SizedBox(
                  width: 24,
                  height: 24,
                  child: Checkbox(
                    value: true,
                    onChanged: (v) {},
                    activeColor: theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'I agree to the Terms of Service and Privacy Policy',
                    style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            ElectroButton(
              text: 'Create Account',
              onPressed: () => context.go('/mobile-entry'),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account? ",
                  style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                ),
                GestureDetector(
                  onTap: () => context.go('/login'),
                  child: Text(
                    'Login',
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
