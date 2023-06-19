import 'package:expansion_app/Models/expense.dart';
import 'package:expansion_app/Widget/expanses_list/expenses_list.dart';
import 'package:expansion_app/Widget/new_expense.dart';
import 'package:expansion_app/main.dart';
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
        isScrollControlled: true,
        context: context,
        builder: (ctx) => NewExapense(
              onAddExpense: _addExpense,
            ));
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registerdExpensed.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registerdExpensed.indexOf(expense);
    setState(() {
      _registerdExpensed.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(seconds: 7),
        action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            _registerdExpensed.insert(expenseIndex, expense);
          },
        ),
        content: const Text("Expense Deleted")));
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child: Text("No response found. Start Adding some "),
    );
    if (_registerdExpensed.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registerdExpensed,
        onRemoveExpense: _removeExpense,
      );
    }
    return Scaffold(
      appBar: AppBar(title: const Text("Flutter ExpenseTracker"), actions: [
        IconButton(onPressed: _openAddExpensedOverlay, icon: Icon(Icons.add))
      ]),
      body: Column(children: [
        Text('the chart'),
        Expanded(
          child: mainContent,
        )
      ]),
    );
  }
}
