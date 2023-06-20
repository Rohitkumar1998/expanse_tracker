import 'package:expansion_app/Widget/expanses_list/expense_item.dart';
import 'package:flutter/material.dart';
import 'package:expansion_app/Models/expense.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(
      {super.key, required this.expenses, required this.onRemoveExpense});
  final List<Expense> expenses;
  final void Function(Expense) onRemoveExpense;
  @override
  Widget build(context) {
    return ListView.builder(
        itemCount: expenses.length,
        itemBuilder: ((ctx, index) => Dismissible(
            background: Container(
                color: Theme.of(context).colorScheme.error,
                margin: EdgeInsets.symmetric(
                  horizontal: Theme.of(context).cardTheme.margin!.horizontal,
                )),
            key: ValueKey(expenses[index]),
            onDismissed: (direction) {
              onRemoveExpense(expenses[index]);
            },
            child: ExpenseItem(expenses[index]))));
  }
}
