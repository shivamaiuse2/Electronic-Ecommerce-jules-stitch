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

class RazerBrandStoreScreen extends StatelessWidget {
  const RazerBrandStoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final allRazer = ProductRepository.allProducts.where((p) => p.name.toLowerCase().contains('razer')).toList();

    return BlocBuilder<FilterBloc, FilterState>(
      builder: (context, filterState) {
        var products = allRazer.where((p) {
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
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 200,
                pinned: true,
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
                flexibleSpace: FlexibleSpaceBar(
                  title: const Text('RAZER STORE'),
                  background: Container(
                    color: Colors.black,
                    child: Center(
                      child: Icon(Icons.mouse, size: 80, color: theme.colorScheme.primary),
                    ),
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.all(AppConstants.containerMargin),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                Text(
                  'For Gamers. By Gamers.',
                  style: theme.textTheme.headlineMedium?.copyWith(color: theme.colorScheme.primary),
                ),
                const SizedBox(height: 8),
                Text(
                  'Explore the latest high-performance gaming hardware from Razer.',
                  style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                ),
                const SizedBox(height: 24),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.65,
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
                  ]),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
