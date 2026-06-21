import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_constants.dart';

class CategoryHubScreen extends StatelessWidget {
  const CategoryHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final categories = [
      {'name': 'Laptops', 'icon': Icons.laptop_mac, 'color': Colors.blue},
      {'name': 'Gaming', 'icon': Icons.sports_esports, 'color': Colors.purple},
      {'name': 'Audio', 'icon': Icons.headphones, 'color': Colors.orange},
      {'name': 'Wearables', 'icon': Icons.watch, 'color': Colors.pink},
      {'name': 'Smart Home', 'icon': Icons.home_max, 'color': Colors.teal},
      {'name': 'Cameras', 'icon': Icons.camera_alt, 'color': Colors.red},
      {'name': 'Accessories', 'icon': Icons.mouse, 'color': Colors.amber},
      {'name': 'TV & Video', 'icon': Icons.tv, 'color': Colors.indigo},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('All Categories'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(AppConstants.containerMargin),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.5,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return GestureDetector(
            onTap: () => context.push('/search?category=${category['name']}'),
            child: Container(
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceVariant.withOpacity(0.3),
                borderRadius: BorderRadius.circular(AppConstants.borderRadiusDefault),
                border: Border.all(color: theme.colorScheme.outlineVariant.withOpacity(0.2)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(category['icon'] as IconData, size: 32, color: theme.colorScheme.primary),
                  const SizedBox(height: 8),
                  Text(
                    category['name'] as String,
                    style: theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
