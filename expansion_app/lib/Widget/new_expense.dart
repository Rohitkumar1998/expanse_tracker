import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';

import 'package:expansion_app/Models/expense.dart';

final formatter = DateFormat.yMd();

class NewExapense extends StatefulWidget {
  const NewExapense({super.key, required this.onAddExpense});
  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExapense> createState() => _NewExapenseState();
}

class _NewExapenseState extends State<NewExapense> {
  // var _enteredTitle = '';
  // void _saveTitle(String inputValue) {
  //   _enteredTitle = inputValue;
  // }
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCatagery = Category.leisure;
  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);

    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _showDailog() {
    if (Platform.isIOS) {
      showCupertinoDialog(
          context: context,
          builder: (ctx) => CupertinoAlertDialog(
                title: const Text('Invaild input'),
                content: const Text('Please make sure a valid title,'
                    'amount ,date, and Categry was entered'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                      },
                      child: Text('Okay'))
                ],
              ));
    } else {
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text('Invaild input'),
                content: const Text('Please make sure a valid title,'
                    'amount ,date, and Categry was entered'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                      },
                      child: Text('Okay'))
                ],
              ));
    }
  }

  void _submitExpenseData() {
    final enterAmouunt = double.tryParse(_amountController.text);
    final amountIsInvalid = enterAmouunt == null || enterAmouunt <= 0;
    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      _showDailog();

      return;
      // show error message
    }
    widget.onAddExpense(Expense(
        title: _titleController.text,
        amount: enterAmouunt,
        category: _selectedCatagery,
        date: _selectedDate!));
    Navigator.pop(context);
  }

//this value stored once availble
  @override
  void dispose() {
    _amountController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyBordSpace = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(builder: (ctx, Constraints) {
      final width = Constraints.maxWidth;

      return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, keyBordSpace + 16),
            child: Column(children: [
              if (width >= 600)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TextField(
                        // onChanged: _saveTitle,
                        controller: _titleController,
                        maxLength: 50,
                        decoration: const InputDecoration(label: Text('Title')),
                      ),
                    ),
                    const SizedBox(
                      width: 24,
                    ),
                    Expanded(
                      child: TextField(
                        controller: _amountController,
                        keyboardType: TextInputType.number,
                        maxLength: 50,
                        decoration: const InputDecoration(
                            prefixText: '\$', label: Text('Amount')),
                      ),
                    ),
                  ],
                )
              else
                TextField(
                  // onChanged: _saveTitle,
                  controller: _titleController,
                  maxLength: 50,
                  decoration: const InputDecoration(label: Text('Title')),
                ),
              if (width >= 600)
                Row(
                  children: [
                    DropdownButton(
                        value: _selectedCatagery,
                        items: Category.values
                            .map((category) => DropdownMenuItem(
                                value: category,
                                child: Text(category.name.toUpperCase())))
                            .toList(),
                        onChanged: (value) {
                          if (value == null) {
                            return;
                          }
                          setState(() {
                            _selectedCatagery = value;
                          });
                        }),
                    const SizedBox(
                      width: 24,
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            _selectedDate == null
                                ? 'Not date selected'
                                : formatter.format(_selectedDate!),
                          ),
                          (IconButton(
                              onPressed: _presentDatePicker,
                              icon: Icon(Icons.calendar_month)))
                        ],
                      ),
                    )
                  ],
                )
              else
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _amountController,
                        keyboardType: TextInputType.number,
                        maxLength: 50,
                        decoration: const InputDecoration(
                            prefixText: '\$', label: Text('Amount')),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            _selectedDate == null
                                ? 'Not date selected'
                                : formatter.format(_selectedDate!),
                          ),
                          (IconButton(
                              onPressed: _presentDatePicker,
                              icon: Icon(Icons.calendar_month)))
                        ],
                      ),
                    )
                  ],
                ),
              SizedBox(
                height: 16,
              ),
              if (width >= 600)
                Row(
                  children: [
                    Spacer(),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('cancel')),
                    ElevatedButton(
                        onPressed: _submitExpenseData, child: Text("Save "))
                  ],
                )
              else
                Row(
                  children: [
                    DropdownButton(
                        value: _selectedCatagery,
                        items: Category.values
                            .map((category) => DropdownMenuItem(
                                value: category,
                                child: Text(category.name.toUpperCase())))
                            .toList(),
                        onChanged: (value) {
                          if (value == null) {
                            return;
                          }
                          setState(() {
                            _selectedCatagery = value;
                          });
                        }),
                    Spacer(),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('cancel')),
                    ElevatedButton(
                        onPressed: _submitExpenseData, child: Text("Save "))
                  ],
                )
            ]),
          ),
        ),
      );
    });
  }
}
