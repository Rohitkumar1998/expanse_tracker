import 'package:expansion_app/Widget/expanses_list/expenses_list.dart';
import 'package:flutter/material.dart';
import 'package:expansion_app/Models/expense.dart';

class Expanses extends StatefulWidget {
  const Expanses({super.key});

  @override
  State<Expanses> createState() {
    return _ExpansesState();
  }
}

class _ExpansesState extends State<Expanses> {
  final List<Expense> _registerExpenses = [
    Expense(
        title: 'FLutter',
        amount: 19.99,
        date: DateTime.now(),
        category: Category.work),
    Expense(
        title: 'Cinema',
        amount: 19.99,
        date: DateTime.now(),
        category: Category.leisure),
  ];
  @override
  Widget build(context) {
    return Scaffold(
        body: Column(
      children: [
        Text("constant"),
        Expanded(child: ExpensesList(expenses: _registerExpenses))
      ],
    ));
  }
}
