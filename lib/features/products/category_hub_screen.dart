import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constants/app_constants.dart';
import '../../shared/widgets/category_item.dart';
import '../products/search_results_screen.dart';
import 'package:go_router/go_router.dart';

class CategoryHubScreen extends StatelessWidget {
  const CategoryHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final categories = [
      {'name': 'Laptops', 'icon': Icons.laptop_mac},
      {'name': 'Gaming', 'icon': Icons.sports_esports},
      {'name': 'Audio', 'icon': Icons.headphones},
      {'name': 'Wearables', 'icon': Icons.watch},
      {'name': 'Smart Home', 'icon': Icons.home_max},
      {'name': 'Cameras', 'icon': Icons.camera_alt},
      {'name': 'Accessories', 'icon': Icons.mouse},
      {'name': 'TV & Video', 'icon': Icons.tv},
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
          childAspectRatio: 1.2,
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
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(category['icon'] as IconData, size: 32, color: theme.colorScheme.primary),
                  ),
                  const SizedBox(height: 12),
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
