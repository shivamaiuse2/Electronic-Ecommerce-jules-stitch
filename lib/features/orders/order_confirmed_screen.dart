import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_constants.dart';
import '../../shared/widgets/electro_button.dart';

class OrderConfirmedScreen extends StatelessWidget {
  const OrderConfirmedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(AppConstants.containerMargin),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.check_circle, size: 80, color: theme.colorScheme.primary),
            ),
            const SizedBox(height: 32),
            Text(
              'Order Confirmed!',
              style: theme.textTheme.displayLarge?.copyWith(fontWeight: FontWeight.w800, fontSize: 32),
            ),
            const SizedBox(height: 16),
            Text(
              'Your order #ES-94201 has been placed successfully. We are preparing it for shipment.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.onSurfaceVariant),
            ),
            const SizedBox(height: 48),
            ElectroButton(
              text: 'Track Order',
              onPressed: () => context.go('/track-order'),
            ),
            const SizedBox(height: 16),
            ElectroButton(
              text: 'Continue Shopping',
              backgroundColor: Colors.transparent,
              textColor: theme.colorScheme.primary,
              onPressed: () => context.go('/home'),
            ),
          ],
        ),
      ),
    );
  }
}
