import 'package:expansion_app/Widget/expanses_list/expense_item.dart';
import 'package:flutter/material.dart';
import 'package:expansion_app/Models/expense.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({super.key, required this.expenses});
  final List<Expense> expenses;
  @override
  Widget build(context) {
    return ListView.builder(
        itemCount: expenses.length,
        itemBuilder: ((ctx, index) => ExpenseItem(expenses[index])));
  }
}
