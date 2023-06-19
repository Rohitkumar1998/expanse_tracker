import 'package:expansion_app/Models/expense.dart';
import 'package:expansion_app/Widget/expanses_list/expenses_list.dart';
import 'package:expansion_app/Widget/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  // List<Expense> expense;
  @override
  State<Expenses> createState() => ExpensesState();
}

class ExpensesState extends State<Expenses> {
  final List<Expense> _registerdExpensed = [
    Expense(
        title: 'Flutter',
        amount: 19.99,
        category: Category.food,
        date: DateTime.now()),
    Expense(
        title: 'Copurse',
        amount: 18.8,
        category: Category.travel,
        date: DateTime.now())
  ];
  void _openAddExpensedOverlay() {
    //
    showModalBottomSheet(
        context: context, builder: (ctx) => const NewExapense());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Flutter ExpenseTracker"), actions: [
        IconButton(onPressed: _openAddExpensedOverlay, icon: Icon(Icons.add))
      ]),
      body: Column(children: [
        Text('the chart'),
        Expanded(child: ExpensesList(expenses: _registerdExpensed))
      ]),
    );
  }
}
