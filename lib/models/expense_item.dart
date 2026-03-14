import 'package:hive/hive.dart';

part 'expense_item.g.dart';

@HiveType(typeId: 0)
class ExpenseItem {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final double amount;
  @HiveField(2)
  final DateTime dateTime;

  ExpenseItem({
    required this.name,
    required this.amount,
    required this.dateTime,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpenseItem &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          amount == other.amount &&
          dateTime == other.dateTime;

  @override
  int get hashCode => name.hashCode ^ amount.hashCode ^ dateTime.hashCode;
}
