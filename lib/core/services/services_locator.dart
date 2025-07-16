import 'package:clean_architecture_poktani/core/network/dio_client.dart';
import 'package:clean_architecture_poktani/features/auth/data/repository/auth_repository_impl.dart';
import 'package:clean_architecture_poktani/features/auth/data/source/auth_api_service.dart';
import 'package:clean_architecture_poktani/features/auth/domain/repository/auth_repository.dart';
import 'package:clean_architecture_poktani/features/auth/domain/usecase/signup_usecases.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

void seupServiceLocator() {
  sl.registerSingleton<DioClient>(DioClient());

  //services
  sl.registerSingleton<AuthApiService>(AuthApiServiceImpl());

  //repositories
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());

  // usecases
  sl.registerSingleton<SignupUsecase>(SignupUsecase());
}
