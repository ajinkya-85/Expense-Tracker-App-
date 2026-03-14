import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';

class ExpenseHeatmap extends StatelessWidget {
  final Map<String, double> dailyExpenseSummary;
  final DateTime startDate;

  const ExpenseHeatmap({
    super.key,
    required this.dailyExpenseSummary,
    required this.startDate,
  });

  @override
  Widget build(BuildContext context) {
    // Convert the YYYYMMDD String Map to a DateTime Map required by the Heatmap
    Map<DateTime, int> datasets = {};

    dailyExpenseSummary.forEach((dateString, amount) {
      if (dateString.length == 8) {
        int year = int.parse(dateString.substring(0, 4));
        int month = int.parse(dateString.substring(4, 6));
        int day = int.parse(dateString.substring(6, 8));

        // Determine the intensity level based on the amount
        int intensity;
        if (amount <= 0) {
          intensity = 0;
        } else if (amount > 0 && amount <= 200) {
          intensity = 1;
        } else if (amount > 200 && amount <= 400) {
          intensity = 2;
        } else if (amount > 400 && amount <= 600) {
          intensity = 3;
        } else if (amount > 600 && amount <= 800) {
          intensity = 4;
        } else {
          intensity = 5;
        }

        // Only add to dataset if there was an expense
        if (intensity > 0) {
          datasets[DateTime(year, month, day)] = intensity;
        }
      }
    });

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Daily Summary",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 10),
          HeatMap(
            startDate: startDate,
            endDate: DateTime.now(),
            datasets: datasets,
            colorMode: ColorMode.color,
            showText: false,
            scrollable: true,
            size: 25,
            showColorTip: false,
            defaultColor: Theme.of(
              context,
            ).colorScheme.surfaceVariant.withOpacity(0.3),
            textColor: Colors.transparent,
            colorsets: {
              1: Colors.blue.shade100,
              2: Colors.blue.shade300,
              3: Colors.blue.shade500,
              4: Colors.blue.shade700,
              5: Colors.blue.shade900,
            },
            onClick: (value) {
              // Optional: Add behavior when tapping a specific date
            },
          ),
        ],
      ),
    );
  }
}
