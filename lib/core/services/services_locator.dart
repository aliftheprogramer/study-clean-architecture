// import 'package:clean_architecture_poktani/common/bloc/auth/auth_state_cubit.dart';
import 'package:clean_architecture_poktani/core/network/dio_client.dart';
import 'package:clean_architecture_poktani/core/network/map_dio_lient.dart';
import 'package:clean_architecture_poktani/features/crop/data/repository_impl/crop_repository_impl.dart';
import 'package:clean_architecture_poktani/features/crop/data/source/crop_api_service.dart';
import 'package:clean_architecture_poktani/features/crop/domain/repository/crop_repository.dart';
import 'package:clean_architecture_poktani/features/crop/domain/usecase/add_crop_usecase.dart';
import 'package:clean_architecture_poktani/features/field/data/repository_impl/soil_type_repository_impl.dart';
import 'package:clean_architecture_poktani/features/field/domain/usecase/detail_field_usecase.dart';
import 'package:clean_architecture_poktani/features/map/data/source/geocoding_api_services.dart';
import 'package:clean_architecture_poktani/features/auth/data/repository/auth_repository_impl.dart';
import 'package:clean_architecture_poktani/features/auth/data/source/auth_api_service.dart';
import 'package:clean_architecture_poktani/features/auth/data/source/auth_local_service.dart';
import 'package:clean_architecture_poktani/features/auth/domain/repository/auth_repository.dart';
import 'package:clean_architecture_poktani/features/auth/domain/usecase/is_logged_in.dart';
import 'package:clean_architecture_poktani/features/auth/domain/usecase/signin_usecases.dart';
import 'package:clean_architecture_poktani/features/auth/domain/usecase/signup_usecases.dart';
import 'package:clean_architecture_poktani/features/field/data/repository_impl/field_repository_impl.dart';
import 'package:clean_architecture_poktani/features/map/data/repository_impl/map_repository_impl.dart';
import 'package:clean_architecture_poktani/features/field/data/source/field_api_services.dart';
import 'package:clean_architecture_poktani/features/field/data/source/soil_type_api_services.dart';
import 'package:clean_architecture_poktani/features/field/domain/repository/field_repository.dart';
import 'package:clean_architecture_poktani/features/map/domain/repository/map_repository.dart';
import 'package:clean_architecture_poktani/features/field/domain/repository/soil_type_repository.dart';
import 'package:clean_architecture_poktani/features/field/domain/usecase/add_field_usecase.dart';
import 'package:clean_architecture_poktani/features/field/domain/usecase/field_usecase.dart';
import 'package:clean_architecture_poktani/features/field/domain/usecase/get_soil_type_usecase.dart';
import 'package:clean_architecture_poktani/features/map/domain/usecase/map_usecase.dart';
import 'package:clean_architecture_poktani/features/profile/data/repository/user_repository_impl.dart';
import 'package:clean_architecture_poktani/features/profile/data/source/profile_api_service.dart';
import 'package:clean_architecture_poktani/features/profile/domain/repository/user_repository.dart';
import 'package:clean_architecture_poktani/features/profile/domain/usecase/get_user.dart';
import 'package:clean_architecture_poktani/features/profile/domain/usecase/logout.dart';
import 'package:clean_architecture_poktani/features/seed/data/repository_impl/seed_repository_impl.dart';
import 'package:clean_architecture_poktani/features/seed/data/source/seed_api_service.dart';
import 'package:clean_architecture_poktani/features/seed/domain/repository/seed_repository.dart';
import 'package:clean_architecture_poktani/features/seed/domain/usecase/get_seeds_usecase.dart';
import 'package:clean_architecture_poktani/features/units/data/repository_impl/unit_repository_impl.dart';
import 'package:clean_architecture_poktani/features/units/data/source/unit_api_service.dart';
import 'package:clean_architecture_poktani/features/units/domain/repository/unit_repository.dart';
import 'package:clean_architecture_poktani/features/units/domain/usecase/get_units_usecase.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

void setupServiceLocator() {
  sl.registerSingleton<DioClient>(DioClient());
  sl.registerSingleton<MapDioClient>(MapDioClient());

  //services
  sl.registerSingleton<AuthApiService>(AuthApiServiceImpl());
  sl.registerSingleton<AuthLocalService>(AuthLocalServiceImpl());
  sl.registerSingleton<ProfileApiService>(ProfileApiServiceImpl());
  sl.registerSingleton<FieldApiServices>(FieldApiServicesImpl());
  sl.registerSingleton<GeocodingApiService>(GeocodingApiServiceImpl());
  sl.registerSingleton<SoilTypeApiServices>(SoilTypeApiServicesImpl());
  sl.registerSingleton<CropApiService>(CropApiServiceImpl());

  // Units feature
  sl.registerLazySingleton<UnitApiService>(() => UnitApiServiceImpl());
  sl.registerLazySingleton<UnitRepository>(() => UnitRepositoryImpl());
  sl.registerLazySingleton<GetUnitsUseCase>(() => GetUnitsUseCase());

  // Seed feature
  sl.registerLazySingleton<SeedApiService>(() => SeedApiServiceImpl());
  sl.registerLazySingleton<SeedRepository>(() => SeedRepositoryImpl());
  sl.registerLazySingleton<GetSeedsUseCase>(() => GetSeedsUseCase());

  //repositories
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());
  sl.registerSingleton<UserRepository>(UserRepositoryImpl());
  sl.registerSingleton<FieldRepository>(FieldRepositoryImpl());
  sl.registerSingleton<GeocodingRepository>(GeocodingRepositoryImpl());
  sl.registerSingleton<SoilTypeRepository>(SoilTypeRepositoryImpl());
  sl.registerSingleton<CropRepository>(CropRepositoryImpl());

  // usecases
  sl.registerSingleton<SignupUsecase>(SignupUsecase());
  sl.registerSingleton<IsLoggedInUseCase>(IsLoggedInUseCase());
  sl.registerSingleton<GetUserUseCase>(GetUserUseCase());
  sl.registerSingleton<LogoutUseCase>(LogoutUseCase());
  sl.registerSingleton<SigninUsecases>(SigninUsecases());
  sl.registerSingleton<GetListFieldsUseCase>(GetListFieldsUseCase());
  sl.registerSingleton<AddFieldUseCase>(AddFieldUseCase());
  sl.registerSingleton<GetAddressFromCoordinatesUseCase>(
    GetAddressFromCoordinatesUseCase(sl<GeocodingRepository>()),
  );
  sl.registerSingleton<GetSoilTypeUsecase>(GetSoilTypeUsecase());
  sl.registerSingleton<GetDetailFieldUseCase>(GetDetailFieldUseCase());
  sl.registerSingleton<AddCropUsecase>(AddCropUsecase());
}
