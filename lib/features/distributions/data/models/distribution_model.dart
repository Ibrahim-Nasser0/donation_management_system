class DistributionModel {
  final int distID;
  final int donorID;
  final int caseID;
  final int employeeID;
  final double distAmount;
  final String notes;
  final DateTime date;

  DistributionModel({
    required this.distID,
    required this.donorID,
    required this.caseID,
    required this.employeeID,
    required this.distAmount,
    required this.notes,
    required this.date,
  });
}
