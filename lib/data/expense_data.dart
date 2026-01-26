import 'package:expense_tracker/DateTime/date_time_helper.dart';
import 'package:expense_tracker/models/expense_item.dart';
import 'package:flutter/material.dart';

class ExpenseData extends ChangeNotifier {
  //list of all the expenses
  List<ExpenseItem> overallExpenseList = [];

  // get all expense
  List<ExpenseItem> getallExpenseList() {
    return overallExpenseList;
  }

  // add new expense
  void addNewExpense(ExpenseItem newItem) {
    overallExpenseList.add(newItem);
    notifyListeners();
  }

  // delete an expense
  void deleteExpense(ExpenseItem iteam) {
    overallExpenseList.remove(iteam);
    notifyListeners();
  }

  //get the date for the start of the week (sunday)
  DateTime startOfWeekDate() {
    DateTime? startOfWeek;

    // get todays date
    DateTime today = DateTime.now();

    for (int i = 0; i < 7; i++) {
      if (getDayName(today.subtract(Duration(days: i))) == "sun") {
        startOfWeek = today.subtract(Duration(days: i));
      }
    }
    return startOfWeek ??
        today.subtract(
          Duration(days: today.weekday - 1),
        ); //provided default value
  }

  // get weekday expense from the datatime obj.
  String getDayName(DateTime date) {
    switch (date.weekday) {
      case 1:
        return "Mon";
      case 2:
        return "Tue";
      case 3:
        return "Wed";
      case 4:
        return "Thur";
      case 5:
        return "Fri";
      case 6:
        return "Sat";
      case 7:
        return "Sun";
      default:
        return " ";
    }
  }

  /*
    convert overall list of expenses into a daily expense summary 

    overallExpenseList =
    [
    [name , datetime, amount],
    [food , 2016/01/19, 400Rs]
    ]

    ->
    we need another list dailyExpenseSummery 

  */

  // calculate expense summery

  Map<String, double> calculateDailyExpenseSummery() {
    Map<String, double> dailyExpenseSummery = {
      //{(yyyymmdd) ; amountTotalForDay}
    };

    for (var expense in overallExpenseList) {
      String date = converDateTimeToString(expense.dateTime);
      double amount = double.parse(expense.amount);

      if (dailyExpenseSummery.containsKey(date)) {
        double currentAmount = dailyExpenseSummery[date]!;
        currentAmount += amount;
        dailyExpenseSummery[date] = currentAmount;
      } else {
        dailyExpenseSummery.addAll({date: amount});
      }
    }
    return dailyExpenseSummery;
  }
}
