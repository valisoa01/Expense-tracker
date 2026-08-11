import 'package:go_router/go_router.dart';
import '../screens/home_screen.dart';
import '../screens/expense_detail_screen.dart';
import '../screens/add_expense_screen.dart';
import '../screens/stats_screen.dart';

class AppRoutes {
  static const home = 'home';
  static const detail = 'detail';
  static const add = 'add';
  static const stats = 'stats';
}

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: AppRoutes.home,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/expense/:id',
      name: AppRoutes.detail,
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return ExpenseDetailScreen(expenseId: id);
      },
    ),
    GoRoute(
      path: '/add',
      name: AppRoutes.add,
      builder: (context, state) => const AddExpenseScreen(),
    ),
    GoRoute(
      path: '/stats',
      name: AppRoutes.stats,
      builder: (context, state) => const StatsScreen(),
    ),
  ],
);