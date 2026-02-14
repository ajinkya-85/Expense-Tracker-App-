import 'package:expense_tracker/DateTime/date_time_helper.dart';
import 'package:expense_tracker/bar%20graph/bar_graph.dart';
import 'package:expense_tracker/data/expense_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpenseSummary extends StatelessWidget {
  final DateTime startOfWeek;

  const ExpenseSummary({super.key, required this.startOfWeek});

  @override
  Widget build(BuildContext context) {
    String sunday = converDateTimeToString(
      startOfWeek.add(const Duration(days: 0)),
    );
    String monday = converDateTimeToString(
      startOfWeek.add(const Duration(days: 1)),
    );
    String tuesday = converDateTimeToString(
      startOfWeek.add(const Duration(days: 2)),
    );
    String wednesday = converDateTimeToString(
      startOfWeek.add(const Duration(days: 3)),
    );
    String thursday = converDateTimeToString(
      startOfWeek.add(const Duration(days: 4)),
    );
    String friday = converDateTimeToString(
      startOfWeek.add(const Duration(days: 5)),
    );
    String saturday = converDateTimeToString(
      startOfWeek.add(const Duration(days: 6)),
    );

    return Consumer<ExpenseData>(
      builder: (context, value, child) => SizedBox(
        height: 200,
        child: MyBarGraph(
          maxY: 100,
          monAmount: value.calculateDailyExpenseSummery()[sunday] ?? 0,
          tueAmount: value.calculateDailyExpenseSummery()[monday] ?? 0,
          wedAmount: value.calculateDailyExpenseSummery()[tuesday] ?? 0,
          thurAmount: value.calculateDailyExpenseSummery()[wednesday] ?? 0,
          friAmount: value.calculateDailyExpenseSummery()[thursday] ?? 0,
          satAmount: value.calculateDailyExpenseSummery()[friday] ?? 0,
          sunAmount: value.calculateDailyExpenseSummery()[saturday] ?? 0,
        ),
      ),
    );
  }
}
