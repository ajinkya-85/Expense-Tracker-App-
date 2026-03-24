import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/models/expense_item.dart';

class FirestoreService {
  // Get collection of expenses
  final CollectionReference<Map<String, dynamic>> expenses = FirebaseFirestore
      .instance
      .collection('expenses');

  // CREATE: Add a new expense. Firestore will auto-generate an ID.
  Future<void> addExpense(ExpenseItem expense) async {
    await expenses.add({
      'name': expense.name,
      'amount': expense.amount,
      'dateTime': expense.dateTime,
    });
  }

  // READ: Get a real-time stream of expenses from the database, ordered by date.
  Stream<List<ExpenseItem>> getExpensesStream() {
    return expenses
        .orderBy('dateTime', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs.map((doc) {
            final data = doc.data();
            return ExpenseItem(
              id: doc.id,
              name: data['name'] as String? ?? 'Unknown Expense',
              amount: (data['amount'] as num?)?.toDouble() ?? 0.0,
              dateTime:
                  (data['dateTime'] as Timestamp?)?.toDate() ?? DateTime.now(),
            );
          }).toList(),
        );
  }

  // DELETE: Delete an expense given its document ID
  Future<void> deleteExpense(String docID) {
    return expenses.doc(docID).delete();
  }
}
