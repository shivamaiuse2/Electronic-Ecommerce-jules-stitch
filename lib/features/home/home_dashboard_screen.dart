import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_constants.dart';
import '../../shared/widgets/category_item.dart';
import '../../shared/widgets/glass_card.dart';
import '../../shared/widgets/product_card.dart';
import '../../shared/models/product.dart';
import '../../core/services/product_repository.dart';
import '../cart/cart_bloc.dart';
import '../wishlist/wishlist_bloc.dart';

class HomeDashboardScreen extends StatelessWidget {
  const HomeDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final categories = [
      {'name': 'Laptops', 'icon': Icons.laptop_mac},
      {'name': 'Gaming', 'icon': Icons.sports_esports},
      {'name': 'Audio', 'icon': Icons.headphones},
      {'name': 'Wearables', 'icon': Icons.watch},
      {'name': 'Phones', 'icon': Icons.smartphone},
    ];

    final products = ProductRepository.allProducts;

    return Scaffold(
      drawer: const NavigationDrawerWidget(),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            pinned: true,
            backgroundColor: theme.colorScheme.surface.withOpacity(0.8),
            title: Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundColor: theme.colorScheme.primaryContainer,
                  child: Icon(Icons.person, size: 20, color: theme.colorScheme.onPrimaryContainer),
                ),
                const SizedBox(width: 12),
                Text(
                  'ElectroStream',
                  style: theme.textTheme.headlineLarge?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () => context.push('/search'),
              ),
            ],
          ),
          SliverPadding(
            padding: const EdgeInsets.all(AppConstants.containerMargin),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => context.push('/search'),
                        child: Container(
                          height: 48,
                          decoration: BoxDecoration(
                            color: theme.colorScheme.surfaceVariant.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Row(
                            children: [
                              const SizedBox(width: 16),
                              Icon(Icons.search, color: theme.colorScheme.onSurfaceVariant),
                              const SizedBox(width: 12),
                              Text(
                                'Search gadgets...',
                                style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: AppConstants.stackMd),
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.tertiaryContainer,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Icon(Icons.tune, color: theme.colorScheme.onTertiaryContainer),
                    ),
                  ],
                ),
                const SizedBox(height: AppConstants.sectionGap),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Categories', style: theme.textTheme.headlineMedium),
                    GestureDetector(
                      onTap: () => context.push('/categories'),
                      child: Text('View All', style: theme.textTheme.labelLarge?.copyWith(color: theme.colorScheme.primary)),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 100,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    separatorBuilder: (context, index) => const SizedBox(width: 24),
                    itemBuilder: (context, index) => CategoryItem(
                      name: categories[index]['name'] as String,
                      icon: categories[index]['icon'] as IconData,
                      isActive: index == 0,
                      onTap: () => context.push('/search?category=${categories[index]['name']}'),
                    ),
                  ),
                ),
                const SizedBox(height: AppConstants.sectionGap),
                Container(
                  height: 240,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppConstants.borderRadiusDefault),
                    image: const DecorationImage(
                      image: NetworkImage('https://lh3.googleusercontent.com/aida-public/AB6AXuAFADU2k9s9yi9OiJkrklAPB1BHzW2rjXuwOcoqnMSBgJ3wQZNZLX4gHrdfpapXKyxWZbAStYDdiAlwdl6v8YheC-klwGoTD9868M3mgpMOUmReXgVWMlS-uZyPzI0qLDhW-BRiIfKm7jFOY1bbEnW_SoP7xuX_D9d50W5z0GCTZGInY41hfUImHZbAnJbNvXswXR6iB8MFf22QpFD6YKbLyaQ4wo9nefxW2-JnUr6k2yD4H4n25dVZMYUwI5G0nxjkWLbkxM5nV6w'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppConstants.borderRadiusDefault),
                      gradient: LinearGradient(
                        colors: [
                          theme.colorScheme.surface.withOpacity(0.9),
                          theme.colorScheme.surface.withOpacity(0.4),
                          Colors.transparent,
                        ],
                      ),
                    ),
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            'NEW ARRIVAL',
                            style: theme.textTheme.labelSmall?.copyWith(color: theme.colorScheme.onPrimary, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Next Gen\nMacBook Pro',
                          style: theme.textTheme.displayLarge?.copyWith(fontSize: 24, height: 1.2, color: Colors.white),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: theme.colorScheme.primary,
                            foregroundColor: theme.colorScheme.onPrimary,
                            shape: const StadiumBorder(),
                          ),
                          child: const Text('Buy Now'),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppConstants.sectionGap),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Best Deals', style: theme.textTheme.headlineMedium),
                    Text('Ends in 02:45:11', style: theme.textTheme.labelLarge?.copyWith(color: theme.colorScheme.error)),
                  ],
                ),
                const SizedBox(height: 16),
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
                const SizedBox(height: AppConstants.sectionGap),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class NavigationDrawerWidget extends StatelessWidget {
  const NavigationDrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Drawer(
      backgroundColor: Colors.transparent,
      child: GlassCard(
        borderRadius: 0,
        padding: EdgeInsets.zero,
        child: Column(
          children: [
            Container(
              height: 220,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    theme.colorScheme.primary.withOpacity(0.2),
                    theme.colorScheme.primary.withOpacity(0.05),
                  ],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 36,
                    backgroundColor: theme.colorScheme.primary,
                    child: Icon(Icons.person, size: 40, color: theme.colorScheme.onPrimary),
                  ),
                  const SizedBox(height: 16),
                  Text('John Doe', style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)),
                  Text('john.doe@example.com', style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
                ],
              ),
            ),
            const SizedBox(height: 24),
            _DrawerItem(
              icon: Icons.home_outlined,
              title: 'Home',
              onTap: () => Navigator.pop(context),
            ),
            _DrawerItem(
              icon: Icons.category_outlined,
              title: 'Categories',
              onTap: () {
                Navigator.pop(context);
                context.push('/categories');
              },
            ),
            _DrawerItem(
              icon: Icons.branding_watermark_outlined,
              title: 'Brands',
              onTap: () {
                Navigator.pop(context);
                context.push('/brands');
              },
            ),
            _DrawerItem(
              icon: Icons.shopping_bag_outlined,
              title: 'My Orders',
              onTap: () {
                Navigator.pop(context);
                context.push('/orders');
              },
            ),
            _DrawerItem(
              icon: Icons.compare_arrows,
              title: 'Comparison',
              onTap: () {
                Navigator.pop(context);
                context.push('/compare');
              },
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Divider(color: Colors.white10),
            ),
            _DrawerItem(
              icon: Icons.help_outline,
              title: 'Help & Support',
              onTap: () {
                Navigator.pop(context);
                context.push('/help-support');
              },
            ),
            _DrawerItem(
              icon: Icons.notifications_none,
              title: 'Notifications',
              onTap: () {
                Navigator.pop(context);
                context.push('/notifications');
              },
            ),
            const Spacer(),
            _DrawerItem(
              icon: Icons.logout,
              title: 'Logout',
              isDestructive: true,
              onTap: () => context.go('/gateway'),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool isDestructive;

  const _DrawerItem({
    required this.icon,
    required this.title,
    required this.onTap,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = isDestructive ? Colors.redAccent : theme.colorScheme.onSurface;

    return ListTile(
      onTap: onTap,
      leading: Icon(icon, color: color.withOpacity(0.8)),
      title: Text(
        title,
        style: theme.textTheme.bodyLarge?.copyWith(
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 24),
      horizontalTitleGap: 0,
    );
  }
}
