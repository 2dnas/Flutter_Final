import 'dart:io';

import 'package:final_flutter/data/database.dart';
import 'package:final_flutter/data/model/expenses_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddNewExpense extends StatefulWidget {
  @override
  _AddNewExpenseState createState() => _AddNewExpenseState();
}

class _AddNewExpenseState extends State<AddNewExpense> {
  final _formKey = GlobalKey<FormState>();

  DateTime dateTime;
  TextEditingController expensesTitleController = TextEditingController();
  TextEditingController expensesAmountController = TextEditingController();

  void _showDatePickerIOS(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => Container(
        color: Color.fromARGB(255, 255, 255, 255),
        height: 400,
        child: CupertinoDatePicker(
          mode: CupertinoDatePickerMode.date,
          minimumYear: 2021,
          maximumYear: 2022,
          onDateTimeChanged: (pickedDate) {
            setState(() {
              dateTime = pickedDate;
            });
          },
          initialDateTime: DateTime.now(),
        ),
      ),
    );
  }

  void _showDatePickerAndroid(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020 - 12 - 31),
      lastDate: DateTime(2025),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        dateTime = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Color(0xFFcef7ed),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextFormField(
                controller: expensesTitleController,
                decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                  hintText: "Enter expense title",
                  border: InputBorder.none,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter valid title";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: expensesAmountController,
                decoration: InputDecoration(
                  icon: Icon(Icons.attach_money_rounded),
                  hintText: "Enter expense amount",
                  border: InputBorder.none,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter valid amount";
                  } else if (double.tryParse(value) <= 0) {
                    return "Amount can't be negative or equal to 0";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    dateTime == null
                        ? "Please select date"
                        : DateFormat.yMMMd().format(dateTime),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Color(0XFF267b7b),
                   ),
                    onPressed: () => Platform.isAndroid
                        ? _showDatePickerAndroid(context)
                        : _showDatePickerIOS(context),
                    child: Text("Pick Date"),
                  ),
                ],
              ),
              Divider(),
              Container(
                width: 100,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Color(0XFF267b7b),
                      ),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      Expenses expense = Expenses(
                        expensesTitleController.text,
                        expensesAmountController.text,
                        dateTime,
                      );
                      Database.addExpense(expense);
                      Navigator.pop(context);
                    }
                  },
                  child: Text("ADD"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
