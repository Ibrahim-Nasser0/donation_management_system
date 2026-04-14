import 'package:donation_management_system/core/utils/use_case.dart';
import 'package:donation_management_system/features/dashboard/domain/use_case/get_dashboard_kpis_use_case.dart';
import 'package:donation_management_system/features/dashboard/domain/use_case/get_donation_trends_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  final GetDashboardKpisUseCase getDashboardKpisUseCase;
  final GetDonationTrendsUseCase getDonationTrendsUseCase;

  DashboardCubit({
    required this.getDashboardKpisUseCase,
    required this.getDonationTrendsUseCase,
  }) : super(DashboardInitial());

  Future<void> getDashboardData() async {
    emit(DashboardLoading());
    
    final kpisResult = await getDashboardKpisUseCase(NoParams());
    final trendsResult = await getDonationTrendsUseCase(NoParams());

    kpisResult.fold(
      (failure) => emit(DashboardError(failure.message)),
      (kpis) {
        trendsResult.fold(
          (failure) => emit(DashboardError(failure.message)),
          (trends) => emit(DashboardDataLoaded(kpis: kpis, trends: trends)),
        );
      },
    );
  }
}
