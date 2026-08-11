import 'package:flutter/material.dart';
import '../models/expense.dart';

class CategoryFilterBar extends StatelessWidget {
  final ExpenseCategory? selectedCategory;
  final ValueChanged<ExpenseCategory?> onCategorySelected;

  const CategoryFilterBar({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilterChip(
              label: const Text('Toutes'),
              selected: selectedCategory == null,
              onSelected: (_) => onCategorySelected(null),
            ),
          ),
          ...ExpenseCategory.values.map((category) {
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: FilterChip(
                avatar: Icon(category.icon, size: 18, color: category.color),
                label: Text(category.label),
                selected: selectedCategory == category,
                onSelected: (_) => onCategorySelected(
                  selectedCategory == category ? null : category,
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}