import 'package:equatable/equatable.dart';

class DonationKpisEntity extends Equatable {
  final double totalAmount;
  final int completedCount;
  final int pendingCount;
  final double avgAmount;

  const DonationKpisEntity({
    required this.totalAmount,
    required this.completedCount,
    required this.pendingCount,
    required this.avgAmount,
  });

  @override
  List<Object?> get props => [totalAmount, completedCount, pendingCount, avgAmount];
}
