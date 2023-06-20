import 'package:expansion_app/expenses.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const uuid = Uuid();
final formatter = DateFormat.yMd();

enum Category { food, travel, leisure, work }

const CategoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.leisure: Icons.movie,
  Category.work: Icons.work
};

class Expense {
  Expense(
      {required this.title,
      required this.amount,
      required this.category,
      required this.date})
      : id = uuid.v4();
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;
  //leisure Expense(category:'lesure')
  String get FomattedDate {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  const ExpenseBucket({required this.category, required this.expenses});
  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((expenses) => expenses.category == category)
            .toList();

  final Category category;
  final List<Expense> expenses;
  double get totalExpense {
    double sum = 0;
    for (final expense in expenses) {
      sum = sum + expense.amount;
    }
    return sum;
  }
}
