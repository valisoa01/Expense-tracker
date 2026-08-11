import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/expense_provider.dart';

class ExpenseDetailScreen extends StatelessWidget {
  final String expenseId;

  const ExpenseDetailScreen({super.key, required this.expenseId});

  @override
  Widget build(BuildContext context) {
    final expense = context.watch<ExpenseProvider>().getExpenseById(expenseId);

    if (expense == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Introuvable')),
        body: const Center(child: Text('Cette dépense n\'existe plus.')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(expense.title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${expense.amount.toStringAsFixed(2)} €',
                style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 8),
            Text('Catégorie : ${expense.category.label}'),
            Text('Date : ${expense.date.day}/${expense.date.month}/${expense.date.year}'),
                      ],
        ),
      ),
    );
  }
}