import 'package:expense_tracker/components/expense_heatmap.dart';
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
  // text controllers
  final newExpenseNameController = TextEditingController();
  final newExpenseAmountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // prepare data on startup
    Provider.of<ExpenseData>(context, listen: false).prepareData();
  }

  // add new expense
  void addNewExpense() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add new expense'),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // expense name
            TextField(
              controller: newExpenseNameController,
              decoration: InputDecoration(
                hintText: "Expense Name",
                filled: true,
                fillColor: Theme.of(context).colorScheme.surfaceVariant,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 10),
            // expense amount
            TextField(
              controller: newExpenseAmountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Amount",
                filled: true,
                fillColor: Theme.of(context).colorScheme.surfaceVariant,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ],
        ),
        actions: [
          // cancel button
          TextButton(onPressed: cancel, child: const Text('Cancel')),
          // save button
          ElevatedButton(onPressed: save, child: const Text('Save')),
        ],
      ),
    );
  }

  // save method
  void save() {
    // only save if all fields are filled and amount is valid
    if (newExpenseNameController.text.isNotEmpty &&
        newExpenseAmountController.text.isNotEmpty) {
      double? amount = double.tryParse(newExpenseAmountController.text);

      // if amount is valid, then save
      if (amount != null) {
        // create expense item
        ExpenseItem newExpense = ExpenseItem(
          name: newExpenseNameController.text,
          amount: amount,
          dateTime: DateTime.now(),
        );
        // add the new expense
        Provider.of<ExpenseData>(
          context,
          listen: false,
        ).addNewExpense(newExpense);
      }
    }

    Navigator.pop(context);
    clear();
  }

  // delete expense
  void deleteExpense(ExpenseItem expense) {
    Provider.of<ExpenseData>(context, listen: false).deleteExpense(expense);
  }

  // cancel method
  void cancel() {
    Navigator.pop(context);
    clear();
  }

  // clear controllers
  void clear() {
    newExpenseNameController.clear();
    newExpenseAmountController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
      builder: (context, value, child) {
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          floatingActionButton: FloatingActionButton(
            onPressed: addNewExpense,
            shape: const CircleBorder(),
            child: const Icon(Icons.add),
          ),
          body: CustomScrollView(
            slivers: [
              // App Bar
              SliverAppBar(
                backgroundColor: Theme.of(context).colorScheme.surface,
                expandedHeight: 100,
                floating: true,
                pinned: true,
                flexibleSpace: const FlexibleSpaceBar(
                  title: Text("Expense Tracker"),
                  titlePadding: EdgeInsets.only(left: 16, bottom: 16),
                ),
              ),

              // Heatmap
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ExpenseHeatmap(
                    dailyExpenseSummary: value.calculateDailyExpenseSummery(),
                    startDate: DateTime.now().subtract(
                      const Duration(days: 120),
                    ),
                  ),
                ),
              ),

              // List of expenses
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                sliver: SliverList.builder(
                  itemCount: value.getallExpenseList().length,
                  itemBuilder: (context, index) {
                    var expense = value.getallExpenseList()[index];
                    return ExpenseTile(
                      name: expense.name,
                      amount: expense.amount.toStringAsFixed(2),
                      dateTime: expense.dateTime,
                      deleteTapped: (p0) => deleteExpense(expense),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
