import 'package:flutter/material.dart';
import 'package:expansion_app/Models/expense.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expensed, {super.key});
  final Expense expensed;
  @override
  Widget build(context) {
    return Card(
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  expensed.title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 4,
                ),
                Row(
                  children: [
                    Text('\$${expensed.amount.toStringAsFixed(2)}'),
                    const Spacer(),
                    Row(
                      children: [
                        Icon(CategoryIcons[expensed.category]),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(expensed.FomattedDate)
                      ],
                    )
                  ],
                )
              ],
            )));
  }
}
