import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_constants.dart';
import '../../shared/widgets/electro_button.dart';

class ChoosePaymentMethodScreen extends StatefulWidget {
  const ChoosePaymentMethodScreen({super.key});

  @override
  State<ChoosePaymentMethodScreen> createState() => _ChoosePaymentMethodScreenState();
}

class _ChoosePaymentMethodScreenState extends State<ChoosePaymentMethodScreen> {
  String _selectedMethod = 'card';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Method'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(AppConstants.containerMargin),
              children: [
                _PaymentItem(
                  id: 'card',
                  title: 'Credit / Debit Card',
                  icon: Icons.credit_card,
                  subtitle: 'Visa, Mastercard, Amex',
                  selectedId: _selectedMethod,
                  onChanged: (id) => setState(() => _selectedMethod = id),
                ),
                const SizedBox(height: 16),
                _PaymentItem(
                  id: 'paypal',
                  title: 'PayPal',
                  icon: Icons.account_balance_wallet,
                  subtitle: 'Fast and secure payment',
                  selectedId: _selectedMethod,
                  onChanged: (id) => setState(() => _selectedMethod = id),
                ),
                const SizedBox(height: 16),
                _PaymentItem(
                  id: 'apple',
                  title: 'Apple Pay',
                  icon: Icons.apple,
                  subtitle: 'Simple one-tap payment',
                  selectedId: _selectedMethod,
                  onChanged: (id) => setState(() => _selectedMethod = id),
                ),
                const SizedBox(height: 16),
                _PaymentItem(
                  id: 'cod',
                  title: 'Cash on Delivery',
                  icon: Icons.money,
                  subtitle: 'Pay when you receive',
                  selectedId: _selectedMethod,
                  onChanged: (id) => setState(() => _selectedMethod = id),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(AppConstants.containerMargin),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainer,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.between,
                  children: [
                    Text('Total Amount', style: theme.textTheme.bodyLarge),
                    Text('\$538.92', style: theme.textTheme.headlineMedium?.copyWith(color: theme.colorScheme.primary)),
                  ],
                ),
                const SizedBox(height: 24),
                ElectroButton(
                  text: 'Place Order',
                  onPressed: () => context.push('/order-confirmed'),
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

class _PaymentItem extends StatelessWidget {
  final String id;
  final String title;
  final String subtitle;
  final IconData icon;
  final String selectedId;
  final Function(String) onChanged;

  const _PaymentItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.selectedId,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isSelected = id == selectedId;

    return GestureDetector(
      onTap: () => onChanged(id),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? theme.colorScheme.primaryContainer.withOpacity(0.1) : theme.colorScheme.surfaceVariant.withOpacity(0.3),
          borderRadius: BorderRadius.circular(AppConstants.borderRadiusDefault),
          border: Border.all(
            color: isSelected ? theme.colorScheme.primary : theme.colorScheme.outlineVariant.withOpacity(0.2),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: isSelected ? theme.colorScheme.primary : theme.colorScheme.onSurfaceVariant),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(subtitle, style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
                ],
              ),
            ),
            Radio<String>(
              value: id,
              groupValue: selectedId,
              onChanged: (v) => onChanged(v!),
              activeColor: theme.colorScheme.primary,
            ),
          ],
        ),
      ),
    );
  }
}
