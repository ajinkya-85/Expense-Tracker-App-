import 'package:expense_tracker/models/expense_item.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/data/firestore_service.dart';

class ExpenseData extends ChangeNotifier {
  //list of all the expenses
  List<ExpenseItem> overallExpenseList = [];
  final firestoreService = FirestoreService();

  // Constructor to set up a stream that listens for database changes
  ExpenseData() {
    firestoreService.getExpensesStream().listen((expenses) {
      overallExpenseList = expenses;
      notifyListeners();
    });
  }

  // add new expense
  void addNewExpense(ExpenseItem newItem) async {
    await firestoreService.addExpense(newItem);
    // The stream will automatically update the list.
  }

  // delete an expense
  void deleteExpense(ExpenseItem item) async {
    if (item.id == null) return; // Can't delete an item without an ID
    await firestoreService.deleteExpense(item.id!);
    // The stream will automatically update the list.
  }

  //get the date for the start of the week (sunday)
  DateTime startOfWeekDate() {
    // get todays date
    DateTime today = DateTime.now();
    // The weekday property is 1 for Monday and 7 for Sunday.
    return today.subtract(Duration(days: today.weekday % 7));
  }

  // get weekday expense from the datatime obj.
  String getDayName(DateTime date) {
    // Use the intl package for a more robust and locale-aware solution.
    return DateFormat.E().format(date);
  }

  // converts DateTime object to a string yyyymmdd
  String convertDateTimeToString(DateTime dateTime) {
    return DateFormat('yyyyMMdd').format(dateTime);
  }

  /// Calculates the total expense for each day.
  ///
  /// Returns a map where the key is the date as a string (yyyymmdd)
  /// and the value is the total amount for that day.
  Map<String, double> calculateDailyExpenseSummary() {
    Map<String, double> dailyExpenseSummary = {};

    for (var expense in overallExpenseList) {
      String date = convertDateTimeToString(expense.dateTime);
      double amount = expense.amount;
      // Add the amount to the existing total for the day, or initialize it.
      dailyExpenseSummary[date] = (dailyExpenseSummary[date] ?? 0) + amount;
    }
    return dailyExpenseSummary;
  }
}
