import 'package:hive_flutter/hive_flutter.dart';

import '../models/expense_item.dart';

class HiveDatabase {
  // reference our box
  final _myBox = Hive.box("expense_database");

  // write data
  void saveData(List<ExpenseItem> allExpense) {
    _myBox.put("ALL_EXPENSES", allExpense);
  }

  // read data
  List<ExpenseItem> readData() {
    // Hive returns a List<dynamic>, we need to cast it.
    List<dynamic> savedExpenses = _myBox.get("ALL_EXPENSES") ?? [];
    List<ExpenseItem> allExpenses = savedExpenses.cast<ExpenseItem>().toList();
    return allExpenses;
  }
}
