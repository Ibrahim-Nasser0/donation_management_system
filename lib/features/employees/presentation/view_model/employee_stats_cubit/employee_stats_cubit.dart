import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:donation_management_system/features/employees/domain/use_case/get_employee_kpis_use_case.dart';
import 'package:donation_management_system/features/employees/presentation/view_model/employee_stats_cubit/employee_stats_state.dart';

class EmployeeStatsCubit extends Cubit<EmployeeStatsState> {
  final GetEmployeeKpisUseCase getEmployeeKpisUseCase;

  EmployeeStatsCubit({required this.getEmployeeKpisUseCase}) : super(EmployeeStatsInitial());

  Future<void> getEmployeeKpis() async {
    emit(EmployeeStatsLoading());
    final result = await getEmployeeKpisUseCase();
    result.fold(
      (failure) => emit(EmployeeStatsError(message: failure.message)),
      (kpis) => emit(EmployeeStatsLoaded(kpis: kpis)),
    );
  }
}
