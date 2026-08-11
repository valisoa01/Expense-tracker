import 'package:flutter_test/flutter_test.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/providers/expense_provider.dart';

void main() {
  group('ExpenseProvider', () {
    late ExpenseProvider provider;

    setUp(() async {
      provider = ExpenseProvider();
      await provider.loadExpenses();
    });

    test('charge les dépenses mockées au démarrage', () {
      expect(provider.filteredExpenses, isNotEmpty);
      expect(provider.isLoading, isFalse);
    });

    test('le filtrage par recherche fonctionne', () {
      provider.setSearchQuery('essence');
      expect(
        provider.filteredExpenses.every(
          (e) => e.title.toLowerCase().contains('essence'),
        ),
        isTrue,
      );
    });

    test('le filtrage par catégorie fonctionne', () {
      provider.setSelectedCategory(ExpenseCategory.food);
      expect(
        provider.filteredExpenses.every(
          (e) => e.category == ExpenseCategory.food,
        ),
        isTrue,
      );
    });

    test('ajouter une dépense augmente le total', () async {
      final totalBefore = provider.totalAmount;
      await provider.addExpense(Expense(
        id: 'test',
        title: 'Test',
        amount: 100.0,
        category: ExpenseCategory.other,
        date: DateTime.now(),
      ));
      expect(provider.totalAmount, totalBefore + 100.0);
    });
  });
}