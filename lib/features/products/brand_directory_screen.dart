import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_constants.dart';

class BrandDirectoryScreen extends StatelessWidget {
  const BrandDirectoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final brands = [
      {'name': 'Apple', 'logo': Icons.apple, 'products': 124},
      {'name': 'Samsung', 'logo': Icons.smartphone, 'products': 98},
      {'name': 'Sony', 'logo': Icons.headset, 'products': 65},
      {'name': 'Razer', 'logo': Icons.mouse, 'products': 42},
      {'name': 'Logitech', 'logo': Icons.keyboard, 'products': 56},
      {'name': 'Dell', 'logo': Icons.laptop, 'products': 38},
      {'name': 'HP', 'logo': Icons.laptop_windows, 'products': 45},
      {'name': 'Asus', 'logo': Icons.developer_board, 'products': 33},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Shop by Brand'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(AppConstants.containerMargin),
        itemCount: brands.length,
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final brand = brands[index];
          return GestureDetector(
            onTap: () => context.push('/search?q=${brand['name']}'),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceVariant.withOpacity(0.3),
                borderRadius: BorderRadius.circular(AppConstants.borderRadiusDefault),
              ),
              child: Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(brand['logo'] as IconData, size: 30, color: theme.colorScheme.primary),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      brand['name'] as String,
                      style: theme.textTheme.headlineMedium,
                    ),
                    Text(
                      '${brand['products']} Products',
                      style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                    ),
                  ],
                ),
                const Spacer(),
                Icon(Icons.chevron_right, color: theme.colorScheme.onSurfaceVariant),
              ],
            ),
          ),
        );
      },
      ),
    );
  }
}
