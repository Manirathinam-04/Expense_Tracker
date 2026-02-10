import 'package:hive/hive.dart';

part 'expense_model.g.dart';

@HiveType(typeId: 0)
class ExpenseModel extends HiveObject {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final double amount;
  @HiveField(2)
  final DateTime? date;
  ExpenseModel({required this.title, required this.amount, required this.date});
}
