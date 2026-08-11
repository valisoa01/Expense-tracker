import 'package:flutter/material.dart';
import '../models/expense.dart';

class ExpenseCard extends StatelessWidget {
  final Expense expense;
  final VoidCallback onTap;

  const ExpenseCard({
    super.key,
    required this.expense,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: expense.category.color.withValues(alpha: 0.15),
          child: Icon(expense.category.icon, color: expense.category.color),
        ),
        title: Text(
          expense.title,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(expense.category.label),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '${expense.amount.toStringAsFixed(2)} €',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              '${expense.date.day}/${expense.date.month}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}