import 'package:clean_architecture_poktani/core/services/services_locator.dart';
import 'package:clean_architecture_poktani/features/auth/data/models/login_request_model.dart';
import 'package:clean_architecture_poktani/features/auth/data/models/signup_req.dart';
import 'package:clean_architecture_poktani/features/auth/data/source/auth_api_service.dart';
import 'package:clean_architecture_poktani/features/auth/data/source/auth_local_service.dart';
import 'package:clean_architecture_poktani/features/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

//semua yang ada disini diambil dari auth_repository.dart dan dalem overridenya dari source tapi ke serices_locator.dart dulu
class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<Either> signUp(SignupReqParams signUpReqParams) async {
    Either result = await sl<AuthApiService>().signUp(signUpReqParams);
    return result.fold(
      (error) {
        return Left(error);
      },
      (data) async {
        Response response = data;
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.setString(
          "access_token",
          response.data['data']['access_token'],
        );
        return Right(response);
      },
    );
  }

  @override
  Future<bool> isLoggedIn() async {
    return await sl<AuthLocalService>().isLoggedIn();
  }

  @override
  Future<Either> signIn(SignInReqParams signInReqParams) async {
    Either result = await sl<AuthApiService>().signIn(signInReqParams);
    return result.fold(
      (error) {
        return Left(error);
      },
      (data) async {
        Response response = data;
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.setString(
          "access_token",
          response.data['data']['access_token'],
        );
        return Right(response);
      },
    );
  }
}
