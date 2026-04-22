import 'package:dartz/dartz.dart';
import 'package:donation_management_system/core/network/errors/failure.dart';
import 'package:donation_management_system/features/employees/domain/entity/employee_kpis_entity.dart';
import 'package:donation_management_system/features/employees/domain/repo/employees_repo.dart';

class GetEmployeeKpisUseCase {
  final EmployeesRepo repository;

  GetEmployeeKpisUseCase({required this.repository});

  Future<Either<Failure, EmployeeKpisEntity>> call() async {
    return await repository.getEmployeeKpis();
  }
}
