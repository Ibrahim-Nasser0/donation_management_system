import 'package:dio/dio.dart';
import 'package:donation_management_system/core/network/api/api_consumer.dart';
import 'package:donation_management_system/core/network/api/dio_consumer.dart';
import 'package:donation_management_system/core/network/network_info.dart';
import 'package:donation_management_system/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:donation_management_system/features/auth/data/repo/auth_repo_impl.dart';
import 'package:donation_management_system/features/auth/domain/repo/auth_repo.dart';
import 'package:donation_management_system/features/auth/domain/use_case/login_use_case.dart';
import 'package:donation_management_system/features/auth/presentation/view_model/login_cubit/login_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../../features/dashboard/presentation/view_model/dashboard_cubit/dashboard_cubit.dart';
import '../../features/dashboard/domain/use_case/get_dashboard_kpis_use_case.dart';
import '../../features/dashboard/domain/repo/dashboard_repo.dart';
import '../../features/dashboard/data/repo/dashboard_repo_impl.dart';
import '../../features/dashboard/data/data_source/dashboard_remote_data_source.dart';

final sl = GetIt.instance;

/// Initialize Dependency Injection
Future<void> init() async {
  //! Features - Dashboard
  // Cubits
  sl.registerFactory(() => DashboardCubit(sl()));

  // UseCases
  sl.registerLazySingleton(() => GetDashboardKpisUseCase(sl()));

  // Repositories
  sl.registerLazySingleton<DashboardRepo>(
    () => DashboardRepoImpl(remoteDataSource: sl(), networkInfo: sl()),
  );

  // Data Sources
  sl.registerLazySingleton<DashboardRemoteDataSource>(
    () => DashboardRemoteDataSourceImpl(sl()),
  );

  //! Features - Auth
  // Cubits
  sl.registerFactory(() => LoginCubit(loginUseCase: sl()));

  // UseCases
  sl.registerLazySingleton(() => LoginUseCase(repository: sl()));

  // Repositories
  sl.registerLazySingleton<AuthRepo>(
    () => AuthRepoImpl(remoteDataSource: sl(), networkInfo: sl()),
  );

  // Data Sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(api: sl()),
  );

  //! Core
  sl.registerLazySingleton<ApiConsumer>(() => DioConsumer(dio: sl()));
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => InternetConnectionChecker.createInstance());
}
