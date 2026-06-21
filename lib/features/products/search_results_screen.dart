import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../shared/widgets/product_card.dart';
import '../../shared/models/product.dart';

class SearchResultsScreen extends StatelessWidget {
  final String? query;
  final String? category;

  const SearchResultsScreen({super.key, this.query, this.category});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Mock Data
    final products = [
      Product(
        id: '1',
        name: 'Sony WH-1000XM5',
        category: 'Audio',
        description: 'Premium noise-cancelling headphones.',
        price: 349,
        originalPrice: 349,
        discount: 0,
        image: 'https://lh3.googleusercontent.com/aida-public/AB6AXuAuOxkQWBkSY2790hLPOUf1TwudUCYMbK0xuyTg1Xqg8t7PpGJ9rhvj-6oHoPNXd5fE28yF2V5XnoBWAFhALQwlc-DsJejPZ4KpaBDa0PDXmjYO1JAsXbARbVgRE6eIbOfm8Zz-HSQFxwBCnDta-zMoGM09IT9fEn5QLaPkBKVCZBmEetdt0FHK4qiuuskSiGlYkPgDquQrNy-SX_vjqahEwp7naIbXF4-bYMFc9o7_qdfCJy2B9Kmrw-TdPxlXyq7ypS9LikqNeYM',
        rating: 4.9,
        reviewsCount: 2000,
        specifications: ['30-hour battery life', 'Industry-leading noise cancellation'],
      ),
      Product(
        id: '2',
        name: 'Razer Huntsman V2',
        category: 'Gaming',
        description: 'Optical gaming keyboard.',
        price: 159,
        originalPrice: 199,
        discount: 20,
        image: 'https://lh3.googleusercontent.com/aida-public/AB6AXuC2b2iRelipNbABODEwcOUmm74niEzOY0ZuUgFXMLmfA6kidTEPbb0yE4bDHvbIUW_pXs5TrP4Tfiy26t4FlGlwkJ-G_lZkqMZLnAFaaeiylDrkOD9lpMlzTr5ozo0gkZTqcTONkomzb2s4Rv9_K_BMdJE0fkhKfnxYDcLErgiDvEodm8Loz7LLof1PMKJpqI8ak5Lhx9fljpHIYjZz0JPZRf2mwpLdXUtn4c4vFvEUfAN4H3VDBghNef-bA9-9uKFNA6YcNAXm9GY',
        rating: 4.7,
        reviewsCount: 842,
        specifications: ['Razer Linear Optical Switches', 'Doubleshot PBT Keycaps'],
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(query ?? category ?? 'Search Results'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(icon: const Icon(Icons.tune), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppConstants.containerMargin, vertical: 8),
            child: Row(
              children: [
                Text(
                  '${products.length} Items found',
                  style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                ),
                const Spacer(),
                DropdownButton<String>(
                  value: 'Popularity',
                  items: ['Popularity', 'Price: Low to High', 'Price: High to Low', 'Newest'].map((e) {
                    return DropdownMenuItem(value: e, child: Text(e, style: theme.textTheme.bodySmall));
                  }).toList(),
                  onChanged: (v) {},
                  underline: const SizedBox(),
                  icon: const Icon(Icons.keyboard_arrow_down, size: 16),
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
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
          ),
        ],
      ),
    );
  }
}
