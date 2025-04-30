import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expences_list/expense_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    required this.expenses,
    required this.onExpenseRemoved,
    super.key,
  });

  final List<Expense> expenses;
  final void Function(Expense) onExpenseRemoved;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder:
          (itemCtx, index) => Dismissible(
            background: Container(
              color: Theme.of(context).colorScheme.error,
              margin: EdgeInsets.symmetric(
                horizontal: Theme.of(context).cardTheme.margin!.horizontal,
              ),
            ),
            key: ValueKey(expenses[index]),
            onDismissed: (direction) => onExpenseRemoved(expenses[index]),
            child: ExpenseItem(expenses[index]),
          ),
    );
  }
}
