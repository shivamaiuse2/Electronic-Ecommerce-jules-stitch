import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_constants.dart';
import '../../shared/widgets/product_card.dart';
import '../cart/cart_bloc.dart';
import '../wishlist/wishlist_bloc.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Wishlist'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: BlocBuilder<WishlistBloc, WishlistState>(
        builder: (context, state) {
          if (state.items.isEmpty) {
            return Center(
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
            );
          }

          return GridView.builder(
            padding: const EdgeInsets.all(AppConstants.containerMargin),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.65,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: state.items.length,
            itemBuilder: (context, index) {
              final product = state.items[index];
              return ProductCard(
                product: product,
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
    );
  }
}
