import 'package:flutter_test/flutter_test.dart';
import 'package:expense_tracker/models/expense.dart';

void main() {
  group('Expense model', () {
    test('copyWith remplace uniquement les champs fournis', () {
      final original = Expense(
        id: '1',
        title: 'Courses',
        amount: 20.0,
        category: ExpenseCategory.food,
        date: DateTime(2026, 1, 1),
      );

      final updated = original.copyWith(amount: 35.0);

      expect(updated.id, original.id);
      expect(updated.title, original.title);
      expect(updated.amount, 35.0);
      expect(updated.category, original.category);
    });

    test('chaque catégorie a un label, une icône et une couleur définis', () {
      for (final category in ExpenseCategory.values) {
        expect(category.label, isNotEmpty);
        expect(category.icon, isNotNull);
        expect(category.color, isNotNull);
      }
    });
  });
}