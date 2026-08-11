import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../providers/expense_provider.dart';
import '../providers/theme_provider.dart';
import '../widgets/expense_card.dart';
import '../widgets/search_field.dart';
import '../widgets/category_filter_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ExpenseProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mes dépenses'),
        actions: [
          IconButton(
            icon: const Icon(Icons.bar_chart),
            onPressed: () => context.push('/stats'),
          ),
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: () => context.read<ThemeProvider>().toggleTheme(),
          ),
        ],
      ),
      body: Column(
        children: [
          SearchField(
            value: provider.searchQuery,
            onChanged: (query) => context.read<ExpenseProvider>().setSearchQuery(query),
            hintText: 'Rechercher une dépense...',
          ),
          CategoryFilterBar(
            selectedCategory: provider.selectedCategory,
            onCategorySelected: (category) =>
                context.read<ExpenseProvider>().setSelectedCategory(category),
          ),
          const SizedBox(height: 4),
          Expanded(
            child: provider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : provider.filteredExpenses.isEmpty
                    ? const Center(child: Text('Aucune dépense trouvée'))
                    : ListView.builder(
                        itemCount: provider.filteredExpenses.length,
                        itemBuilder: (context, index) {
                          final expense = provider.filteredExpenses[index];
                          return ExpenseCard(
                            expense: expense,
                            onTap: () => context.push('/expense/${expense.id}'),
                          );
                        },
                      ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/add'),
        child: const Icon(Icons.add),
      ),
    );
  }
}