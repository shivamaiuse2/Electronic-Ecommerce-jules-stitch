import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constants/app_constants.dart';
import '../../shared/widgets/product_card.dart';
import '../../shared/models/product.dart';
import '../../core/services/product_repository.dart';
import '../cart/cart_bloc.dart';
import '../wishlist/wishlist_bloc.dart';
import 'filter_bloc.dart';
import 'filter_bottom_sheet.dart';

class SearchResultsScreen extends StatelessWidget {
  final String? query;
  final String? category;

  const SearchResultsScreen({super.key, this.query, this.category});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final allProducts = ProductRepository.allProducts;

    return BlocBuilder<FilterBloc, FilterState>(
      builder: (context, filterState) {
        var filteredProducts = allProducts.where((p) {
          if (category != null && p.category != category) return false;
          if (query != null && !p.name.toLowerCase().contains(query!.toLowerCase())) return false;
          if (p.price < filterState.minPrice || p.price > filterState.maxPrice) return false;
          return true;
        }).toList();

        // Sort logic
        switch (filterState.sortOption) {
          case SortOption.priceLowToHigh:
            filteredProducts.sort((a, b) => a.price.compareTo(b.price));
            break;
          case SortOption.priceHighToLow:
            filteredProducts.sort((a, b) => b.price.compareTo(a.price));
            break;
          case SortOption.newest:
          case SortOption.popularity:
            break;
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(query ?? category ?? 'Search Results'),
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: [
              IconButton(
                icon: const Icon(Icons.tune),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) => const FilterBottomSheet(),
                  );
                },
              ),
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
      },
    );
  }
}
