import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../shared/widgets/product_card.dart';
import '../../shared/models/product.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Mock Data
    final products = [
      Product(
        id: '1',
        name: 'Sony WH-1000XM5',
        category: 'Audio',
        description: '',
        price: 349,
        originalPrice: 349,
        discount: 0,
        image: 'https://lh3.googleusercontent.com/aida-public/AB6AXuAuOxkQWBkSY2790hLPOUf1TwudUCYMbK0xuyTg1Xqg8t7PpGJ9rhvj-6oHoPNXd5fE28yF2V5XnoBWAFhALQwlc-DsJejPZ4KpaBDa0PDXmjYO1JAsXbARbVgRE6eIbOfm8Zz-HSQFxwBCnDta-zMoGM09IT9fEn5QLaPkBKVCZBmEetdt0FHK4qiuuskSiGlYkPgDquQrNy-SX_vjqahEwp7naIbXF4-bYMFc9o7_qdfCJy2B9Kmrw-TdPxlXyq7ypS9LikqNeYM',
        rating: 4.9,
        reviewsCount: 2000,
        specifications: [],
        isFavorite: true,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Wishlist'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: products.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite_outline, size: 64, color: theme.colorScheme.outlineVariant),
                  const SizedBox(height: 16),
                  Text('Your wishlist is empty', style: theme.textTheme.headlineMedium),
                  const SizedBox(height: 8),
                  Text('Save items you like to see them here later.', style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
                ],
              ),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(AppConstants.containerMargin),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) => ProductCard(
                product: products[index],
                onTap: () {},
                onAddToCart: () {},
              ),
            ),
    );
  }
}
