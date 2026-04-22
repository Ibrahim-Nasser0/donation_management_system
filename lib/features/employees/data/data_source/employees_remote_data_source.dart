import 'package:donation_management_system/core/network/api/api_consumer.dart';
import 'package:donation_management_system/core/network/api/api_endpoints.dart';
import 'package:donation_management_system/features/employees/domain/entity/add_employee_params.dart';

import 'package:donation_management_system/features/employees/domain/entity/employee_entity.dart';

abstract class EmployeesRemoteDataSource {
  Future<void> addEmployee(AddEmployeeParams params);
  Future<List<EmployeeEntity>> getEmployees();
}

class EmployeesRemoteDataSourceImpl implements EmployeesRemoteDataSource {
  final ApiConsumer api;

  EmployeesRemoteDataSourceImpl({required this.api});

  @override
  Future<void> addEmployee(AddEmployeeParams params) async {
    await api.post(ServerStrings.employees, body: params.toJson());
  }

  @override
  Future<List<EmployeeEntity>> getEmployees() async {
    final response = await api.get(ServerStrings.employees);
    // Assuming response is a List of Maps
    final List<dynamic> data = response;
    return data.map((json) => EmployeeEntity.fromJson(json)).toList();
  }
}
