import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constants/app_constants.dart';
import '../../shared/widgets/electro_button.dart';
import 'filter_bloc.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  late double _minPrice;
  late double _maxPrice;
  late SortOption _sortOption;
  String? _selectedCategory;

  @override
  void initState() {
    super.initState();
    final state = context.read<FilterBloc>().state;
    _minPrice = state.minPrice;
    _maxPrice = state.maxPrice;
    _sortOption = state.sortOption;
    _selectedCategory = state.category;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(AppConstants.containerMargin),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.between,
            children: [
              Text('Filters', style: theme.textTheme.headlineMedium),
              TextButton(
                onPressed: () {
                  context.read<FilterBloc>().add(ResetFilters());
                  Navigator.pop(context);
                },
                child: Text('Reset', style: TextStyle(color: theme.colorScheme.error)),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text('Sort By', style: theme.textTheme.labelLarge),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            children: SortOption.values.map((option) {
              final isSelected = _sortOption == option;
              return ChoiceChip(
                label: Text(_getSortName(option)),
                selected: isSelected,
                onSelected: (v) => setState(() => _sortOption = option),
                selectedColor: theme.colorScheme.primary,
                labelStyle: TextStyle(color: isSelected ? theme.colorScheme.onPrimary : theme.colorScheme.onSurface),
              );
            }).toList(),
          ),
          const SizedBox(height: 32),
          Text('Price Range', style: theme.textTheme.labelLarge),
          RangeSlider(
            values: RangeValues(_minPrice, _maxPrice),
            min: 0,
            max: 5000,
            divisions: 50,
            activeColor: theme.colorScheme.primary,
            labels: RangeLabels('\$${_minPrice.toInt()}', '\$${_maxPrice.toInt()}'),
            onChanged: (values) {
              setState(() {
                _minPrice = values.start;
                _maxPrice = values.end;
              });
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.between,
            children: [
              Text('\$${_minPrice.toInt()}', style: theme.textTheme.bodySmall),
              Text('\$${_maxPrice.toInt()}', style: theme.textTheme.bodySmall),
            ],
          ),
          const SizedBox(height: 32),
          ElectroButton(
            text: 'Apply Filters',
            onPressed: () {
              context.read<FilterBloc>().add(UpdateFilters(
                minPrice: _minPrice,
                maxPrice: _maxPrice,
                sortOption: _sortOption,
                category: _selectedCategory,
              ));
              Navigator.pop(context);
            },
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  String _getSortName(SortOption option) {
    switch (option) {
      case SortOption.popularity: return 'Popularity';
      case SortOption.priceLowToHigh: return 'Price: Low to High';
      case SortOption.priceHighToLow: return 'Price: High to Low';
      case SortOption.newest: return 'Newest';
    }
  }
}
