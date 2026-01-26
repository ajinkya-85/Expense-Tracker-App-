import 'package:expense_tracker/bar%20graph/bar_graph.dart';
import 'package:expense_tracker/data/expense_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpenseSummary extends StatelessWidget {
  final DateTime startOfWeek;

  const ExpenseSummary({super.key, required this.startOfWeek});

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
      builder: (context, value, child) => SizedBox(
        height: 200,
        child: MyBarGraph(
          maxY: 200,
          monAmount: 12,
          tueAmount: 30,
          wedAmount: 50,
          thurAmount: 34,
          friAmount: 54,
          satAmount: 23,
          sunAmount: 54,
        ),
      ),
    );
  }
}
