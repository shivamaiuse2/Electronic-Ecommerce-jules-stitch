import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';

class TrackOrderScreen extends StatelessWidget {
  const TrackOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final steps = [
      {'title': 'Order Placed', 'date': 'Oct 24, 2023, 10:30 AM', 'status': 'completed'},
      {'title': 'Processing', 'date': 'Oct 24, 2023, 02:15 PM', 'status': 'completed'},
      {'title': 'Shipped', 'date': 'Expected Oct 25, 2023', 'status': 'active'},
      {'title': 'Out for Delivery', 'date': 'Pending', 'status': 'upcoming'},
      {'title': 'Delivered', 'date': 'Pending', 'status': 'upcoming'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Track Order'),
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
                color: theme.colorScheme.surfaceVariant.withOpacity(0.3),
                borderRadius: BorderRadius.circular(AppConstants.borderRadiusDefault),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Order ID: ES-94201', style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
                        const SizedBox(height: 4),
                        Text('Arriving Tomorrow', style: theme.textTheme.headlineMedium?.copyWith(color: theme.colorScheme.primary)),
                      ],
                    ),
                  ),
                  const Icon(Icons.local_shipping_outlined, size: 48),
                ],
              ),
            ),
            const SizedBox(height: 32),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: steps.length,
              itemBuilder: (context, index) {
                final step = steps[index];
                final isCompleted = step['status'] == 'completed';
                final isActive = step['status'] == 'active';

                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            color: isCompleted || isActive ? theme.colorScheme.primary : theme.colorScheme.outlineVariant,
                            shape: BoxShape.circle,
                          ),
                          child: isCompleted ? const Icon(Icons.check, size: 16, color: Colors.black) : null,
                        ),
                        if (index < steps.length - 1)
                          Container(
                            width: 2,
                            height: 60,
                            color: isCompleted ? theme.colorScheme.primary : theme.colorScheme.outlineVariant,
                          ),
                      ],
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            step['title'] as String,
                            style: theme.textTheme.labelLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: isCompleted || isActive ? theme.colorScheme.onSurface : theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            step['date'] as String,
                            style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
