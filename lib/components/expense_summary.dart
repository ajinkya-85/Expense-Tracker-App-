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
      builder: (context, value, child) {
        String sunday = value.convertDateTimeToString(
          startOfWeek.add(const Duration(days: 0)),
        );
        String monday = value.convertDateTimeToString(
          startOfWeek.add(const Duration(days: 1)),
        );
        String tuesday = value.convertDateTimeToString(
          startOfWeek.add(const Duration(days: 2)),
        );
        String wednesday = value.convertDateTimeToString(
          startOfWeek.add(const Duration(days: 3)),
        );
        String thursday = value.convertDateTimeToString(
          startOfWeek.add(const Duration(days: 4)),
        );
        String friday = value.convertDateTimeToString(
          startOfWeek.add(const Duration(days: 5)),
        );
        String saturday = value.convertDateTimeToString(
          startOfWeek.add(const Duration(days: 6)),
        );

        // Calculate the summary only once per build
        Map<String, double> dailySummary = value.calculateDailyExpenseSummary();

        double sunAmount = dailySummary[sunday] ?? 0;
        double monAmount = dailySummary[monday] ?? 0;
        double tueAmount = dailySummary[tuesday] ?? 0;
        double wedAmount = dailySummary[wednesday] ?? 0;
        double thurAmount = dailySummary[thursday] ?? 0;
        double friAmount = dailySummary[friday] ?? 0;
        double satAmount = dailySummary[saturday] ?? 0;

        // Calculate the maximum amount for the graph's Y-axis to prevent overflow
        double maxAmount = 100;
        List<double> amounts = [
          sunAmount,
          monAmount,
          tueAmount,
          wedAmount,
          thurAmount,
          friAmount,
          satAmount,
        ];
        for (var amount in amounts) {
          if (amount > maxAmount) {
            maxAmount = amount;
          }
        }

        return SizedBox(
          height: 200,
          child: MyBarGraph(
            maxY:
                maxAmount *
                1.1, // Add 10% padding to the top so the bar doesn't touch the ceiling
            sunAmount: sunAmount,
            monAmount: monAmount,
            tueAmount: tueAmount,
            wedAmount: wedAmount,
            thurAmount: thurAmount,
            friAmount: friAmount,
            satAmount: satAmount,
          ),
        );
      },
    );
  }
}
