import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_constants.dart';
import '../../shared/widgets/electro_button.dart';
import '../../shared/models/product.dart';
import '../../shared/models/cart_item.dart';

class ShoppingCartScreen extends StatefulWidget {
  const ShoppingCartScreen({super.key});

  @override
  State<ShoppingCartScreen> createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  final List<CartItem> _items = [
    CartItem(
      product: Product(
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
      quantity: 1,
    ),
    CartItem(
      product: Product(
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
      quantity: 1,
    ),
  ];

  double get subtotal => _items.fold(0, (sum, item) => sum + item.totalPrice);
  double get shipping => 15.0;
  double get tax => subtotal * 0.08;
  double get total => subtotal + shipping + tax;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Cart'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(AppConstants.containerMargin),
              itemCount: _items.length,
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final item = _items[index];
                return Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceVariant.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(AppConstants.borderRadiusDefault),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surface,
                          borderRadius: BorderRadius.circular(AppConstants.borderRadiusSm),
                        ),
                        child: Image.network(item.product.image, fit: BoxFit.contain),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item.product.name, style: theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold)),
                            const SizedBox(height: 4),
                            Text('\$${item.product.price.toInt()}', style: theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.primary, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              _QuantityButton(icon: Icons.remove, onTap: () {
                                if (item.quantity > 1) {
                                  setState(() {
                                    _items[index] = item.copyWith(quantity: item.quantity - 1);
                                  });
                                }
                              }),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 12),
                                child: Text('${item.quantity}', style: theme.textTheme.labelLarge),
                              ),
                              _QuantityButton(icon: Icons.add, onTap: () {
                                setState(() {
                                  _items[index] = item.copyWith(quantity: item.quantity + 1);
                                });
                              }),
                            ],
                          ),
                          const SizedBox(height: 8),
                          IconButton(
                            icon: const Icon(Icons.delete_outline, color: Colors.red, size: 20),
                            onPressed: () {
                              setState(() {
                                _items.removeAt(index);
                              });
                            },
                            constraints: const BoxConstraints(),
                            padding: EdgeInsets.zero,
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(AppConstants.containerMargin),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainer,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 10, offset: const Offset(0, -5)),
              ],
            ),
            child: Column(
              children: [
                _SummaryRow(label: 'Subtotal', value: '\$${subtotal.toStringAsFixed(2)}'),
                const SizedBox(height: 8),
                _SummaryRow(label: 'Shipping', value: '\$${shipping.toStringAsFixed(2)}'),
                const SizedBox(height: 8),
                _SummaryRow(label: 'Tax (8%)', value: '\$${tax.toStringAsFixed(2)}'),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Divider(),
                ),
                _SummaryRow(label: 'Total', value: '\$${total.toStringAsFixed(2)}', isTotal: true),
                const SizedBox(height: 24),
                ElectroButton(
                  text: 'Checkout',
                  onPressed: () => context.push('/address-selection'),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _QuantityButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _QuantityButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: theme.colorScheme.outlineVariant.withOpacity(0.3)),
        ),
        child: Icon(icon, size: 16),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isTotal;

  const _SummaryRow({required this.label, required this.value, this.isTotal = false});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.between,
      children: [
        Text(
          label,
          style: isTotal
              ? theme.textTheme.headlineMedium
              : theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.onSurfaceVariant),
        ),
        Text(
          value,
          style: isTotal
              ? theme.textTheme.headlineMedium?.copyWith(color: theme.colorScheme.primary)
              : theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
