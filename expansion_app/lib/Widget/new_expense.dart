import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:expansion_app/Models/expense.dart';
// final formatter = DateFormat.yMd();

class NewExapense extends StatefulWidget {
  const NewExapense({super.key});

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

//this value stored once availble
  @override
  void dispose() {
    _amountController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(children: [
        TextField(
          // onChanged: _saveTitle,
          controller: _titleController,
          maxLength: 50,
          decoration: const InputDecoration(label: Text('Title')),
        ),
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
              width: 16,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(_selectedDate == null
                      ? 'No dateSelected Date'
                      : formatter.format(_selectedDate!)),
                  (IconButton(
                      onPressed: _presentDatePicker,
                      icon: Icon(Icons.calendar_month)))
                ],
              ),
            )
          ],
        ),
        Row(
          children: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('cancel')),
            ElevatedButton(
                onPressed: () {
                  // print(_enteredTitle);
                  print(_titleController);
                  print(_amountController);
                },
                child: Text("Save "))
          ],
        )
      ]),
    );
  }
}
