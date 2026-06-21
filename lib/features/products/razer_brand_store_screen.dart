import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constants/app_constants.dart';
import '../../shared/widgets/product_card.dart';
import '../../shared/models/product.dart';
import '../cart/cart_bloc.dart';
import '../wishlist/wishlist_bloc.dart';

class RazerBrandStoreScreen extends StatelessWidget {
  const RazerBrandStoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final products = [
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
      Product(
        id: '4',
        name: 'Razer DeathAdder V3 Pro',
        category: 'Gaming',
        description: 'Ultra-lightweight wireless ergonomic esports mouse.',
        price: 149,
        originalPrice: 149,
        discount: 0,
        image: 'https://lh3.googleusercontent.com/aida-public/AB6AXuCHv7Kxy_AE2JWPWgzImlSF2H2mff5uAz5guGPuR5mjWoWwsK3awEQ3J6zz9rvi8AP0ncSSobi1_b1STUURBq6Cx-dZZZirvCreVZDOqeKdm57WdXrgQ-lPrtF-1k-jd_JcFLD9yd3s8MnJca8r1F7Hpxl89KwXVG8jA2gALX2UzM9sLZNqXhn5YfHEFmgYLVokDhhprB3kpX1m9fV7vR7m86p576p4rtHZfDpoe6eDveekGUmfT-WZgIDl6zwCjUW4VGenZeZxJII',
        rating: 4.8,
        reviewsCount: 520,
        specifications: ['63g Ultra-lightweight', 'Focus Pro 30K Optical Sensor'],
      ),
    ];

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
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
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
