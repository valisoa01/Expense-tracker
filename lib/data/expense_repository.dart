import '../models/expense.dart';

class ExpenseRepository {
  final List<Expense> _expenses = [
    Expense(
      id: '1',
      title: 'Courses Carrefour',
      amount: 45.90,
      category: ExpenseCategory.food,
      date: DateTime.now().subtract(const Duration(days: 1)),
    ),
    Expense(
      id: '2',
      title: 'Essence',
      amount: 60.00,
      category: ExpenseCategory.transport,
      date: DateTime.now().subtract(const Duration(days: 2)),
    ),
    Expense(
      id: '3',
      title: 'Cinéma',
      amount: 12.50,
      category: ExpenseCategory.entertainment,
      date: DateTime.now().subtract(const Duration(days: 3)),
      note: 'Sortie entre amis',
    ),
    Expense(
      id: '4',
      title: 'Pharmacie',
      amount: 23.40,
      category: ExpenseCategory.health,
      date: DateTime.now().subtract(const Duration(days: 5)),
    ),
    Expense(
      id: '5',
      title: 'Nouvelles chaussures',
      amount: 89.99,
      category: ExpenseCategory.shopping,
      date: DateTime.now().subtract(const Duration(days: 6)),
    ),
  ];

  Future<List<Expense>> getExpenses() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return List.unmodifiable(_expenses);
  }

  Future<void> addExpense(Expense expense) async {
    _expenses.add(expense);
  }

  Future<void> deleteExpense(String id) async {
    _expenses.removeWhere((e) => e.id == id);
  }
}