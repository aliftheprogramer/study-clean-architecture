import 'package:clean_architecture_poktani/core/constants/api_urls.dart';
import 'package:clean_architecture_poktani/core/network/dio_client.dart';
import 'package:clean_architecture_poktani/core/services/services_locator.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ProfileApiService {
  Future<Either<String, Response>> getUser();
}

class ProfileApiServiceImpl implements ProfileApiService {
  @override
  Future<Either<String, Response>> getUser() async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var token = sharedPreferences.getString('token');
      Logger().i("Token: $token");
      var response = await sl<DioClient>().get(
        ApiUrls.userProfile,
        options: Options(
          headers: {
            'Authorization': "bearer $token",
            'Accept': 'application/json',
          },
        ),
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(e.response?.data['message'] ?? 'An error occurred');
    }
  }
}
