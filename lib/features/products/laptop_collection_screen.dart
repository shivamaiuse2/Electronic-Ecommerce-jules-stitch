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

class LaptopCollectionScreen extends StatelessWidget {
  const LaptopCollectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final allLaptops = ProductRepository.allProducts.where((p) => p.category == 'Laptops').toList();

    return BlocBuilder<FilterBloc, FilterState>(
      builder: (context, filterState) {
        var products = allLaptops.where((p) {
          if (p.price < filterState.minPrice || p.price > filterState.maxPrice) return false;
          return true;
        }).toList();

        // Sort logic
        switch (filterState.sortOption) {
          case SortOption.priceLowToHigh:
            products.sort((a, b) => a.price.compareTo(b.price));
            break;
          case SortOption.priceHighToLow:
            products.sort((a, b) => b.price.compareTo(a.price));
            break;
          default:
            break;
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text('Laptop Collection'),
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
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(AppConstants.containerMargin),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer.withOpacity(0.2),
                borderRadius: BorderRadius.circular(AppConstants.borderRadiusDefault),
                border: Border.all(color: theme.colorScheme.primary.withOpacity(0.2)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Performance Reimagined',
                          style: theme.textTheme.headlineMedium?.copyWith(color: theme.colorScheme.primary),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Discover laptops that push the boundaries of what is possible.',
                          style: theme.textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.laptop_mac, size: 64, color: Colors.white24),
                ],
              ),
            ),
            const SizedBox(height: 32),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.75,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
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
              ],
            ),
          ),
        );
      },
    );
  }
}
