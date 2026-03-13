class DistributionTableModel {
  final String caseName;
  final String donorName;
  final String empolyeeName;
  final double amount;
  final DateTime date;
  final DistributionStatus status;

  DistributionTableModel({
    required this.caseName,
    required this.donorName,
    required this.empolyeeName,
    required this.amount,
    required this.date,
    required this.status,
  });
  
}

enum DistributionStatus { completed, pending, processing, draft }
