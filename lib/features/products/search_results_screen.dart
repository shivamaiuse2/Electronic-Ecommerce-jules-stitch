import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constants/app_constants.dart';
import '../../shared/widgets/product_card.dart';
import '../../shared/models/product.dart';
import '../cart/cart_bloc.dart';
import '../wishlist/wishlist_bloc.dart';

class SearchResultsScreen extends StatelessWidget {
  final String? query;
  final String? category;

  const SearchResultsScreen({super.key, this.query, this.category});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Filter logic simulation
    final allProducts = [
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
      ),
      Product(
        id: '2',
        name: 'Razer Huntsman V2',
        category: 'Gaming',
        description: '',
        price: 159,
        originalPrice: 199,
        discount: 20,
        image: 'https://lh3.googleusercontent.com/aida-public/AB6AXuC2b2iRelipNbABODEwcOUmm74niEzOY0ZuUgFXMLmfA6kidTEPbb0yE4bDHvbIUW_pXs5TrP4Tfiy26t4FlGlwkJ-G_lZkqMZLnAFaaeiylDrkOD9lpMlzTr5ozo0gkZTqcTONkomzb2s4Rv9_K_BMdJE0fkhKfnxYDcLErgiDvEodm8Loz7LLof1PMKJpqI8ak5Lhx9fljpHIYjZz0JPZRf2mwpLdXUtn4c4vFvEUfAN4H3VDBghNef-bA9-9uKFNA6YcNAXm9GY',
        rating: 4.7,
        reviewsCount: 842,
        specifications: [],
      ),
      Product(
        id: '3',
        name: 'MacBook Pro M2',
        category: 'Laptops',
        description: '',
        price: 1999,
        originalPrice: 1999,
        discount: 0,
        image: 'https://lh3.googleusercontent.com/aida-public/AB6AXuAFADU2k9s9yi9OiJkrklAPB1BHzW2rjXuwOcoqnMSBgJ3wQZNZLX4gHrdfpapXKyxWZbAStYDdiAlwdl6v8YheC-klwGoTD9868M3mgpMOUmReXgVWMlS-uZyPzI0qLDhW-BRiIfKm7jFOY1bbEnW_SoP7xuX_D9d50W5z0GCTZGInY41hfUImHZbAnJbNvXswXR6iB8MFf22QpFD6YKbLyaQ4wo9nefxW2-JnUr6k2yD4H4n25dVZMYUwI5G0nxjkWLbkxM5nV6w',
        rating: 4.9,
        reviewsCount: 120,
        specifications: [],
      ),
    ];

    final filteredProducts = allProducts.where((p) {
      if (category != null && p.category != category) return false;
      if (query != null && !p.name.toLowerCase().contains(query!.toLowerCase())) return false;
      return true;
    }).toList();

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
                  '${filteredProducts.length} Items found',
                  style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                ),
                const Spacer(),
                const Icon(Icons.sort, size: 16),
                const SizedBox(width: 8),
                Text('Sort', style: theme.textTheme.bodySmall),
              ],
            ),
          ),
          Expanded(
            child: filteredProducts.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search_off, size: 64, color: theme.colorScheme.outlineVariant),
                        const SizedBox(height: 16),
                        Text('No items found', style: theme.textTheme.headlineMedium),
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
                    itemCount: filteredProducts.length,
                    itemBuilder: (context, index) {
                      final product = filteredProducts[index];
                      return BlocBuilder<WishlistBloc, WishlistState>(
                        builder: (context, wishlistState) {
                          final isFavorite = wishlistState.items.any((i) => i.id == product.id);
                          return ProductCard(
                            product: product.copyWith(isFavorite: isFavorite),
                            onTap: () {},
                            onFavoriteToggle: () {
                              context.read<WishlistBloc>().add(ToggleWishlist(product));
                            },
                            onAddToCart: () {
                              context.read<CartBloc>().add(AddToCart(product));
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('${product.name} added to cart')),
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
