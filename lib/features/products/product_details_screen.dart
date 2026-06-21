import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constants/app_constants.dart';
import '../../shared/models/product.dart';
import '../../shared/widgets/electro_button.dart';
import '../../shared/widgets/glass_card.dart';
import '../cart/cart_bloc.dart';
import '../wishlist/wishlist_bloc.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Product product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int _selectedColor = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 400,
            pinned: true,
            backgroundColor: theme.colorScheme.background,
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: 'product_${widget.product.id}',
                child: Container(
                  color: theme.colorScheme.surfaceVariant.withOpacity(0.2),
                  child: Stack(
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(48.0),
                          child: Image.network(widget.product.image, fit: BoxFit.contain),
                        ),
                      ),
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                theme.colorScheme.background.withOpacity(0.5),
                                theme.colorScheme.background,
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            actions: [
              BlocBuilder<WishlistBloc, WishlistState>(
                builder: (context, state) {
                  final isFavorite = state.items.any((i) => i.id == widget.product.id);
                  return IconButton(
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: theme.colorScheme.primary,
                    ),
                    onPressed: () {
                      context.read<WishlistBloc>().add(ToggleWishlist(widget.product));
                    },
                  );
                },
              ),
              IconButton(icon: const Icon(Icons.share_outlined), onPressed: () {}),
              const SizedBox(width: 8),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(AppConstants.containerMargin),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.between,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primaryContainer.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          widget.product.category,
                          style: theme.textTheme.labelSmall?.copyWith(color: theme.colorScheme.primary, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(
                        children: [
                          Icon(Icons.star, color: theme.colorScheme.tertiary, size: 20),
                          const SizedBox(width: 4),
                          Text(
                            '${widget.product.rating} (${widget.product.reviewsCount} reviews)',
                            style: theme.textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.product.name,
                    style: theme.textTheme.displayLarge?.copyWith(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '\$${widget.product.price.toInt()}',
                        style: theme.textTheme.headlineLarge?.copyWith(
                          color: theme.colorScheme.primary,
                          fontSize: 32,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      if (widget.product.originalPrice > widget.product.price) ...[
                        const SizedBox(width: 12),
                        Text(
                          '\$${widget.product.originalPrice.toInt()}',
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 32),
                  Text('Colors', style: theme.textTheme.headlineMedium?.copyWith(fontSize: 18)),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      _ColorOption(color: Colors.black, isSelected: _selectedColor == 0, onTap: () => setState(() => _selectedColor = 0)),
                      _ColorOption(color: Colors.grey, isSelected: _selectedColor == 1, onTap: () => setState(() => _selectedColor = 1)),
                      _ColorOption(color: theme.colorScheme.primary, isSelected: _selectedColor == 2, onTap: () => setState(() => _selectedColor = 2)),
                    ],
                  ),
                  const SizedBox(height: 32),
                  Text('Description', style: theme.textTheme.headlineMedium?.copyWith(fontSize: 18)),
                  const SizedBox(height: 12),
                  Text(
                    widget.product.description,
                    style: theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.onSurfaceVariant, height: 1.6),
                  ),
                  const SizedBox(height: 32),
                  Text('Specifications', style: theme.textTheme.headlineMedium?.copyWith(fontSize: 18)),
                  const SizedBox(height: 12),
                  ...widget.product.specifications.map((spec) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        Icon(Icons.check_circle_outline, size: 18, color: theme.colorScheme.primary),
                        const SizedBox(width: 12),
                        Text(spec, style: theme.textTheme.bodyMedium),
                      ],
                    ),
                  )),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.all(AppConstants.containerMargin),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface.withOpacity(0.9),
          border: Border(top: BorderSide(color: theme.colorScheme.outlineVariant.withOpacity(0.2))),
        ),
        child: Row(
          children: [
            Expanded(
              child: ElectroButton(
                text: 'Add to Cart',
                onPressed: () {
                  context.read<CartBloc>().add(AddToCart(widget.product));
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${widget.product.name} added to cart'),
                      backgroundColor: theme.colorScheme.primary,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ColorOption extends StatelessWidget {
  final Color color;
  final bool isSelected;
  final VoidCallback onTap;

  const _ColorOption({required this.color, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 16),
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: isSelected ? Theme.of(context).colorScheme.primary : Colors.transparent, width: 2),
        ),
        child: Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
      ),
    );
  }
}
