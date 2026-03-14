class ExpenseItem {
  final String? id; // Firestore document ID
  final String name;
  final double amount;
  final DateTime dateTime;

  ExpenseItem({
    this.id,
    required this.name,
    required this.amount,
    required this.dateTime,
  });

  // For comparing ExpenseItem objects. Two items are the same if their Firestore ID is the same.
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpenseItem &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
