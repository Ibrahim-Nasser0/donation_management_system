import 'package:donation_management_system/features/dashboard/domain/entity/donation_trends_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:donation_management_system/features/dashboard/domain/entity/dashboard_kpis_entity.dart';

abstract class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object?> get props => [];
}

class DashboardInitial extends DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardDataLoaded extends DashboardState {
  final DashboardKpis kpis;
  final DonationTrends trends;

  const DashboardDataLoaded({required this.kpis, required this.trends});

  @override
  List<Object?> get props => [kpis, trends];
}

class DashboardError extends DashboardState {
  final String message;

  const DashboardError(this.message);

  @override
  List<Object?> get props => [message];
}
