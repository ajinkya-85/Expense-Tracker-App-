import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/expense_item.dart';

class FirestoreService {
  // Get collection of expenses
  final CollectionReference expenses = FirebaseFirestore.instance.collection(
    'expenses',
  );

  // CREATE: Add a new expense. Firestore will auto-generate an ID.
  Future<void> addExpense(ExpenseItem expense) {
    return expenses.add({
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
            final data = doc.data() as Map<String, dynamic>;
            return ExpenseItem(
              id: doc.id,
              name: data['name'],
              amount: (data['amount'] as num).toDouble(),
              dateTime: (data['dateTime'] as Timestamp).toDate(),
            );
          }).toList(),
        );
  }

  // DELETE: Delete an expense given its document ID
  Future<void> deleteExpense(String docID) {
    return expenses.doc(docID).delete();
  }
}
