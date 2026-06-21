import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_constants.dart';
import '../../shared/widgets/electro_button.dart';
import 'address_bloc.dart';

class SelectDeliveryAddressScreen extends StatelessWidget {
  const SelectDeliveryAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Delivery Address'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: BlocBuilder<AddressBloc, AddressState>(
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(AppConstants.containerMargin),
                  itemCount: state.addresses.length + 1,
                  separatorBuilder: (context, index) => const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    if (index == state.addresses.length) {
                      return OutlinedButton.icon(
                        onPressed: () => context.push('/add-address'),
                        icon: const Icon(Icons.add),
                        label: const Text('Add New Address'),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.all(16),
                          side: BorderSide(color: theme.colorScheme.primary),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                      );
                    }

                    final address = state.addresses[index];
                    final isSelected = state.selectedIndex == index;

                    return GestureDetector(
                      onTap: () => context.read<AddressBloc>().add(SelectAddress(index)),
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
                            Radio<int>(
                              value: index,
                              groupValue: state.selectedIndex,
                              onChanged: (v) => context.read<AddressBloc>().add(SelectAddress(v!)),
                              activeColor: theme.colorScheme.primary,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(address.title, style: theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 4),
                                  Text('${address.street}, ${address.city}, ${address.state} ${address.zip}', style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
                                  const SizedBox(height: 4),
                                  Text(address.phone, style: theme.textTheme.bodySmall),
                                ],
                              ),
                            ),
                            IconButton(onPressed: () {}, icon: const Icon(Icons.edit_outlined, size: 20)),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(AppConstants.containerMargin),
                child: ElectroButton(
                  text: 'Continue to Payment',
                  onPressed: () => context.push('/payment-method'),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
