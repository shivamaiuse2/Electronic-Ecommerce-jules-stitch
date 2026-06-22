import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';

class CategoryItem extends StatelessWidget {
  final String name;
  final IconData icon;
  final bool isActive;
  final VoidCallback onTap;

  const CategoryItem({
    super.key,
    required this.name,
    required this.icon,
    this.isActive = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: isActive ? theme.colorScheme.primary : theme.colorScheme.surfaceVariant.withOpacity(0.5),
              shape: BoxShape.circle,
              boxShadow: isActive ? [
                BoxShadow(
                  color: theme.colorScheme.primary.withOpacity(0.3),
                  blurRadius: 15,
                  offset: const Offset(0, 0),
                )
              ] : null,
              border: isActive ? Border.all(color: theme.colorScheme.surfaceVariant, width: 4) : null,
            ),
            child: Icon(
              icon,
              size: 28,
              color: isActive ? theme.colorScheme.onPrimary : theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: AppConstants.stackSm),
          Text(
            name,
            style: theme.textTheme.labelLarge?.copyWith(
              color: isActive ? theme.colorScheme.onSurface : theme.colorScheme.onSurfaceVariant,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
