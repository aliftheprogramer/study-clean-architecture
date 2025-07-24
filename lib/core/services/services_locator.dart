// import 'package:clean_architecture_poktani/common/bloc/auth/auth_state_cubit.dart';
import 'package:clean_architecture_poktani/core/network/dio_client.dart';
import 'package:clean_architecture_poktani/features/auth/data/repository/auth_repository_impl.dart';
import 'package:clean_architecture_poktani/features/auth/data/source/auth_api_service.dart';
import 'package:clean_architecture_poktani/features/auth/data/source/auth_local_service.dart';
import 'package:clean_architecture_poktani/features/auth/domain/repository/auth_repository.dart';
import 'package:clean_architecture_poktani/features/auth/domain/usecase/is_logged_in.dart';
import 'package:clean_architecture_poktani/features/auth/domain/usecase/signin_usecases.dart';
import 'package:clean_architecture_poktani/features/auth/domain/usecase/signup_usecases.dart';
import 'package:clean_architecture_poktani/features/field/data/repository_impl/field_repository_impl.dart';
import 'package:clean_architecture_poktani/features/field/data/source/field_api_services.dart';
import 'package:clean_architecture_poktani/features/field/domain/repository/field_repository.dart';
import 'package:clean_architecture_poktani/features/field/domain/usecase/field_usecase.dart';
import 'package:clean_architecture_poktani/features/profile/data/repository/user_repository_impl.dart';
import 'package:clean_architecture_poktani/features/profile/data/source/profile_api_service.dart';
import 'package:clean_architecture_poktani/features/profile/domain/repository/user_repository.dart';
import 'package:clean_architecture_poktani/features/profile/domain/usecase/get_user.dart';
import 'package:clean_architecture_poktani/features/profile/domain/usecase/logout.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

void setupServiceLocator() {
  sl.registerSingleton<DioClient>(DioClient());

  //services
  sl.registerSingleton<AuthApiService>(AuthApiServiceImpl());
  sl.registerSingleton<AuthLocalService>(AuthLocalServiceImpl());
  sl.registerSingleton<ProfileApiService>(ProfileApiServiceImpl());
  sl.registerSingleton<FieldApiServices>(FieldApiServicesImpl());

  //repositories
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());
  sl.registerSingleton<UserRepository>(UserRepositoryImpl());
  sl.registerSingleton<FieldRepository>(FieldRepositoryImpl());

  // usecases
  sl.registerSingleton<SignupUsecase>(SignupUsecase());
  sl.registerSingleton<IsLoggedInUseCase>(IsLoggedInUseCase());
  sl.registerSingleton<GetUserUseCase>(GetUserUseCase());
  sl.registerSingleton<LogoutUseCase>(LogoutUseCase());
  sl.registerSingleton<SigninUsecases>(SigninUsecases());
  sl.registerSingleton<GetListFieldsUseCase>(GetListFieldsUseCase());
}
