import 'package:dartz/dartz.dart';
import 'package:donation_management_system/core/network/errors/failure.dart';
import 'package:donation_management_system/features/employees/domain/entity/add_employee_params.dart';
import 'package:donation_management_system/features/employees/domain/entity/employee_entity.dart';

abstract class EmployeesRepo {
  Future<Either<Failure, void>> addEmployee(AddEmployeeParams params);
  Future<Either<Failure, List<EmployeeEntity>>> getEmployees();
}
