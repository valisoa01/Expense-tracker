import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/expense_provider.dart';
import 'providers/theme_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ExpenseProvider()..loadExpenses()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          return MaterialApp(
            title: 'Expense Tracker',
            themeMode: themeProvider.themeMode,
            theme: ThemeData(brightness: Brightness.light, useMaterial3: true),
            darkTheme: ThemeData(brightness: Brightness.dark, useMaterial3: true),
            home: const _TempHomePlaceholder(),
          );
        },
      ),
    );
  }
}

class _TempHomePlaceholder extends StatelessWidget {
  const _TempHomePlaceholder();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Test Provider')),
      body: Consumer<ExpenseProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView(
            children: provider.filteredExpenses
                .map((e) => ListTile(
                      title: Text(e.title),
                      subtitle: Text(e.category.label),
                      trailing: Text('${e.amount.toStringAsFixed(2)} €'),
                    ))
                .toList(),
          );
        },
      ),
    );
  }
}