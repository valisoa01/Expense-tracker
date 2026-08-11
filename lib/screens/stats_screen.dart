import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/expense.dart';
import '../providers/expense_provider.dart';
import '../utils/responsive.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ExpenseProvider>();
    final expenses = provider.expensesForStats;

    final Map<ExpenseCategory, double> totalsByCategory = {
      for (final category in ExpenseCategory.values)
        category: expenses
            .where((e) => e.category == category)
            .fold(0.0, (sum, e) => sum + e.amount),
    };

    return Scaffold(
      appBar: AppBar(title: const Text('Statistiques')),
      body: expenses.isEmpty
          ? const Center(child: Text('Aucune dépense à analyser'))
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Card(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Text(
                          'Total dépensé',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${provider.totalAmount.toStringAsFixed(2)} €',
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Par catégorie',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 12),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: ExpenseCategory.values.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: Responsive.gridColumns(context),
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 1.4,
                  ),
                  itemBuilder: (context, index) {
                    final category = ExpenseCategory.values[index];
                    final total = totalsByCategory[category] ?? 0;
                    final percentage = provider.totalAmount > 0
                        ? (total / provider.totalAmount * 100)
                        : 0.0;

                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(category.icon, color: category.color),
                            const Spacer(),
                            Text(
                              category.label,
                              style: const TextStyle(fontWeight: FontWeight.w600),
                            ),
                            Text('${total.toStringAsFixed(2)} €'),
                            Text(
                              '${percentage.toStringAsFixed(0)}%',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
    );
  }
}