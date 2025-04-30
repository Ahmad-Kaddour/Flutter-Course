import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:expense_tracker/widgets/expences_list/expenses_list.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [];

  void _addNewExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      constraints: BoxConstraints(maxWidth: double.infinity),
      builder: (ctx) => NewExpense(onNewExpenseEntered: _addNewExpense),
    );
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 3),
        content: Text('Expense deleted'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed:
              () => {
                setState(() {
                  _registeredExpenses.insert(expenseIndex, expense);
                }),
              },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    Widget mainContent = Center(
      child: Text('No expenses found. Start adding some!'),
    );

    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpenses,
        onExpenseRemoved: _removeExpense,
      );
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Expense Tracker'),
          actions: [
            IconButton(
              onPressed: _openAddExpenseOverlay,
              icon: Icon(Icons.add),
            ),
          ],
        ),
        body:
            screenWidth < 600
                ? Column(
                  children: [
                    Chart(expenses: _registeredExpenses),
                    Expanded(child: mainContent),
                  ],
                )
                : Row(
                  children: [
                    Expanded(child: Chart(expenses: _registeredExpenses)),
                    Expanded(child: mainContent),
                  ],
                ),
      ),
    );
  }
}
