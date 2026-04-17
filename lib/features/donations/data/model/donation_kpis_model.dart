import 'package:donation_management_system/features/donations/domain/entity/donation_kpis_entity.dart';

class DonationKpisModel extends DonationKpisEntity {
  const DonationKpisModel({
    required super.totalAmount,
    required super.completedCount,
    required super.pendingCount,
    required super.avgAmount,
  });

  factory DonationKpisModel.fromJson(Map<String, dynamic> json) {
    return DonationKpisModel(
      totalAmount: (json['totalAmount'] as num).toDouble(),
      completedCount: json['completedCount'] as int,
      pendingCount: json['pendingCount'] as int,
      avgAmount: (json['avgAmount'] as num).toDouble(),
    );
  }
}
