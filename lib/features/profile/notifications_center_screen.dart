import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';

class NotificationsCenterScreen extends StatelessWidget {
  const NotificationsCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final notifications = [
      {
        'title': 'Order Shipped',
        'desc': 'Your order #ES-94201 has been shipped and is on its way.',
        'time': '2 hours ago',
        'icon': Icons.local_shipping_outlined,
        'color': theme.colorScheme.primary,
      },
      {
        'title': 'New Arrival',
        'desc': 'The all-new MacBook Pro M2 is now available in store.',
        'time': '5 hours ago',
        'icon': Icons.bolt,
        'color': theme.colorScheme.tertiary,
      },
      {
        'title': 'Price Drop',
        'desc': 'An item in your wishlist has a new lower price!',
        'time': '1 day ago',
        'icon': Icons.trending_down,
        'color': Colors.blue,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(AppConstants.containerMargin),
        itemCount: notifications.length,
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final note = notifications[index];
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceVariant.withOpacity(0.3),
              borderRadius: BorderRadius.circular(AppConstants.borderRadiusDefault),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: (note['color'] as Color).withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(note['icon'] as IconData, color: note['color'] as Color, size: 24),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(note['title'] as String, style: theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text(note['desc'] as String, style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
                      const SizedBox(height: 8),
                      Text(note['time'] as String, style: theme.textTheme.labelSmall?.copyWith(fontSize: 10, color: theme.colorScheme.outline)),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
