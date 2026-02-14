import 'dart:ffi';

import 'package:expense_tracker/components/expense_summary.dart';
import 'package:expense_tracker/components/expense_tile.dart';
import 'package:expense_tracker/data/expense_data.dart';
import 'package:expense_tracker/models/expense_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final newExpenseNameController = TextEditingController();
  final newExpenseAmountController = TextEditingController();

  void addNewExpense() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Add new expense"),
        content: Column(
          mainAxisSize: MainAxisSize.min, //to minimize the hight of colum.
          children: [
            //Expense name
            TextField(controller: newExpenseNameController),
            //Expense amount
            TextField(controller: newExpenseAmountController),
          ],
        ),
        actions: [
          //save
          MaterialButton(onPressed: save, child: Text("Save")),
          //cancel
          MaterialButton(onPressed: cancel, child: Text("Cancel")),
        ],
      ),
    );
  }

  //save
  void save() {
    ExpenseItem newExpense = ExpenseItem(
      name: newExpenseNameController.text,
      amount: newExpenseAmountController.text,
      dateTime: DateTime.now(),
    );
    //added new expense.
    Provider.of<ExpenseData>(context, listen: false).addNewExpense(newExpense);
    clear();
    Navigator.pop(context);
  }

  //cancel
  void cancel() {
    clear();
    Navigator.pop(context);
  }

  //clear filed
  void clear() {
    newExpenseAmountController.clear();
    newExpenseNameController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: Colors.grey[300],
        floatingActionButton: FloatingActionButton(
          onPressed: addNewExpense,
          child: Icon(Icons.add, color: Colors.white),
          backgroundColor: Colors.black,
        ),
        body: ListView(
          children: [
            //weekly summary
            ExpenseSummary(startOfWeek: value.startOfWeekDate()),

            const SizedBox(height: 20),
            //expense list
            ListView.builder(
              shrinkWrap: true,
              itemCount: value.getallExpenseList().length,
              itemBuilder: (context, index) => ExpenseTile(
                name: value.getallExpenseList()[index].name,
                amount: value.getallExpenseList()[index].amount,
                dateTime: value.getallExpenseList()[index].dateTime,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
