import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../shared/models/product.dart';

class ProductComparisonScreen extends StatelessWidget {
  const ProductComparisonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final products = [
      Product(
        id: '1',
        name: 'MacBook Pro M2',
        category: 'Laptops',
        description: '',
        price: 1999,
        originalPrice: 1999,
        discount: 0,
        image: 'https://lh3.googleusercontent.com/aida-public/AB6AXuAFADU2k9s9yi9OiJkrklAPB1BHzW2rjXuwOcoqnMSBgJ3wQZNZLX4gHrdfpapXKyxWZbAStYDdiAlwdl6v8YheC-klwGoTD9868M3mgpMOUmReXgVWMlS-uZyPzI0qLDhW-BRiIfKm7jFOY1bbEnW_SoP7xuX_D9d50W5z0GCTZGInY41hfUImHZbAnJbNvXswXR6iB8MFf22QpFD6YKbLyaQ4wo9nefxW2-JnUr6k2yD4H4n25dVZMYUwI5G0nxjkWLbkxM5nV6w',
        rating: 4.9,
        reviewsCount: 120,
        specifications: ['M2 Chip', '16GB RAM', '512GB SSD', '14-inch Display'],
      ),
      Product(
        id: '3',
        name: 'Dell XPS 15',
        category: 'Laptops',
        description: '',
        price: 1849,
        originalPrice: 1849,
        discount: 0,
        image: 'https://lh3.googleusercontent.com/aida-public/AB6AXuCHv7Kxy_AE2JWPWgzImlSF2H2mff5uAz5guGPuR5mjWoWwsK3awEQ3J6zz9rvi8AP0ncSSobi1_b1STUURBq6Cx-dZZZirvCreVZDOqeKdm57WdXrgQ-lPrtF-1k-jd_JcFLD9yd3s8MnJca8r1F7Hpxl89KwXVG8jA2gALX2UzM9sLZNqXhn5YfHEFmgYLVokDhhprB3kpX1m9fV7vR7m86p576p4rtHZfDpoe6eDveekGUmfT-WZgIDl6zwCjUW4VGenZeZxJII',
        rating: 4.6,
        reviewsCount: 85,
        specifications: ['i7 13th Gen', '16GB RAM', '1TB SSD', '15.6-inch Display'],
      ),
    ];

    final specs = ['Processor', 'Memory', 'Storage', 'Display', 'Price'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Compare Products'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.containerMargin),
        child: Column(
          children: [
            Row(
              children: products.map((p) => Expanded(
                child: Column(
                  children: [
                    Image.network(p.image, height: 100, fit: BoxFit.contain),
                    const SizedBox(height: 8),
                    Text(p.name, textAlign: TextAlign.center, style: theme.textTheme.labelLarge),
                  ],
                ),
              )).toList(),
            ),
            const SizedBox(height: 32),
            ...List.generate(specs.length, (index) {
              return Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: theme.colorScheme.outlineVariant.withOpacity(0.2))),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(specs[index], style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
                    const SizedBox(height: 8),
                    Row(
                      children: products.map((p) => Expanded(
                        child: Text(
                          index == 4 ? '\$${p.price.toInt()}' : p.specifications[index],
                          style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      )).toList(),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
