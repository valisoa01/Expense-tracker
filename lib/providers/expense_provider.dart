import 'package:flutter/foundation.dart';
import '../models/expense.dart';
import '../data/expense_repository.dart';

class ExpenseProvider extends ChangeNotifier {
  final ExpenseRepository _repository = ExpenseRepository();

  List<Expense> _expenses = [];
  List<Expense> get expensesForStats => _expenses;
  bool _isLoading = false;
  String _searchQuery = '';
  ExpenseCategory? _selectedCategory;

  bool get isLoading => _isLoading;
  String get searchQuery => _searchQuery;
  ExpenseCategory? get selectedCategory => _selectedCategory;
  List<Expense> get filteredExpenses {
    return _expenses.where((expense) {
      final matchesSearch = expense.title
          .toLowerCase()
          .contains(_searchQuery.toLowerCase());
      final matchesCategory =
          _selectedCategory == null || expense.category == _selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();
  }

  double get totalAmount =>
      _expenses.fold(0, (sum, e) => sum + e.amount);

  Future<void> loadExpenses() async {
    _isLoading = true;
    notifyListeners();

    _expenses = await _repository.getExpenses();

    _isLoading = false;
    notifyListeners();
  }

  Future<void> addExpense(Expense expense) async {
    await _repository.addExpense(expense);
    await loadExpenses();
  }

  Future<void> deleteExpense(String id) async {
    await _repository.deleteExpense(id);
    await loadExpenses();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void setSelectedCategory(ExpenseCategory? category) {
    _selectedCategory = category;
    notifyListeners();
  }

  Expense? getExpenseById(String id) {
    try {
      return _expenses.firstWhere((e) => e.id == id);
    } catch (_) {
      return null;
    }
  }
}