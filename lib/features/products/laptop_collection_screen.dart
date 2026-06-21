import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constants/app_constants.dart';
import '../../shared/widgets/product_card.dart';
import '../../shared/models/product.dart';
import '../cart/cart_bloc.dart';
import '../wishlist/wishlist_bloc.dart';

class LaptopCollectionScreen extends StatelessWidget {
  const LaptopCollectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final products = [
      Product(
        id: '1',
        name: 'MacBook Pro M2',
        category: 'Laptops',
        description: 'Next Gen MacBook Pro with M2 Chip.',
        price: 1999,
        originalPrice: 1999,
        discount: 0,
        image: 'https://lh3.googleusercontent.com/aida-public/AB6AXuAFADU2k9s9yi9OiJkrklAPB1BHzW2rjXuwOcoqnMSBgJ3wQZNZLX4gHrdfpapXKyxWZbAStYDdiAlwdl6v8YheC-klwGoTD9868M3mgpMOUmReXgVWMlS-uZyPzI0qLDhW-BRiIfKm7jFOY1bbEnW_SoP7xuX_D9d50W5z0GCTZGInY41hfUImHZbAnJbNvXswXR6iB8MFf22QpFD6YKbLyaQ4wo9nefxW2-JnUr6k2yD4H4n25dVZMYUwI5G0nxjkWLbkxM5nV6w',
        rating: 4.9,
        reviewsCount: 120,
        specifications: ['M2 Chip', '16GB RAM', '512GB SSD'],
      ),
      Product(
        id: '3',
        name: 'Dell XPS 15',
        category: 'Laptops',
        description: 'Thin and light powerful laptop.',
        price: 1849,
        originalPrice: 1849,
        discount: 0,
        image: 'https://lh3.googleusercontent.com/aida-public/AB6AXuCHv7Kxy_AE2JWPWgzImlSF2H2mff5uAz5guGPuR5mjWoWwsK3awEQ3J6zz9rvi8AP0ncSSobi1_b1STUURBq6Cx-dZZZirvCreVZDOqeKdm57WdXrgQ-lPrtF-1k-jd_JcFLD9yd3s8MnJca8r1F7Hpxl89KwXVG8jA2gALX2UzM9sLZNqXhn5YfHEFmgYLVokDhhprB3kpX1m9fV7vR7m86p576p4rtHZfDpoe6eDveekGUmfT-WZgIDl6zwCjUW4VGenZeZxJII',
        rating: 4.6,
        reviewsCount: 85,
        specifications: ['i7 13th Gen', '16GB RAM', '1TB SSD'],
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Laptop Collection'),
        backgroundColor: Colors.transparent,
        elevation: 0,
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
  }
}
