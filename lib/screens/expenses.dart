import 'package:flutter/material.dart';
import 'package:flutter_application_1/chart/chart.dart';
import 'package:flutter_application_1/models/expense.dart';
import 'package:flutter_application_1/widgets/expenses_list/expenses_list.dart';
import 'package:flutter_application_1/widgets/expenses_list/new_expenses.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpenses(onAddExpense: _addExpense),
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Expense Deleted'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expenses'),
        actions: [
          IconButton(
            onPressed: () {
              _openAddExpenseOverlay();
            },
            icon: const Icon(Icons.add, color: Colors.black, size: 20),
            style: ButtonStyle(
              // #FEE0D6
              backgroundColor: WidgetStatePropertyAll(Color(0xFFFEE0D6)),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.dark_mode, color: Colors.black, size: 20),
            style: ButtonStyle(
              // #FEE0D6
              backgroundColor: WidgetStatePropertyAll(Color(0xFFFEE0D6)),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          if (_registeredExpenses.isEmpty)
            const SizedBox(
              height: 200,
              child: Center(child: Text('No Expenses Found')),
            ),
          if (_registeredExpenses.isNotEmpty)
            CategoryBarChart(expenses: _registeredExpenses),
          Expanded(
            child: ExpensesList(
              expenses: _registeredExpenses,
              onRemoveExpense: _removeExpense,
            ),
          ),
        ],
      ),
    );
  }
}
