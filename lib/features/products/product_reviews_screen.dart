import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';

class ProductReviewsScreen extends StatelessWidget {
  const ProductReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final reviews = [
      {
        'user': 'Alex Johnson',
        'rating': 5,
        'date': '2 days ago',
        'comment': 'Absolutely love these headphones! The sound quality is unmatched and the noise cancellation is magic.',
      },
      {
        'user': 'Sarah Smith',
        'rating': 4,
        'date': '1 week ago',
        'comment': 'Great build quality. A bit pricey but worth it for the comfort.',
      },
      {
        'user': 'Mike Ross',
        'rating': 5,
        'date': '2 weeks ago',
        'comment': 'Best investment I have made for my home office setup.',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer Reviews'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.containerMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('4.9', style: theme.textTheme.displayLarge?.copyWith(fontSize: 48, fontWeight: FontWeight.bold)),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: List.generate(5, (index) => Icon(Icons.star, color: theme.colorScheme.tertiary, size: 20)),
                    ),
                    Text('Based on 2,450 reviews', style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 32),
            ...reviews.map((review) => Container(
              margin: const EdgeInsets.only(bottom: 24),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceVariant.withOpacity(0.3),
                borderRadius: BorderRadius.circular(AppConstants.borderRadiusDefault),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(review['user'] as String, style: theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold)),
                      Text(review['date'] as String, style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: List.generate(5, (index) => Icon(
                      Icons.star,
                      color: index < (review['rating'] as int) ? theme.colorScheme.tertiary : theme.colorScheme.outlineVariant,
                      size: 16,
                    )),
                  ),
                  const SizedBox(height: 12),
                  Text(review['comment'] as String, style: theme.textTheme.bodyMedium),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}
