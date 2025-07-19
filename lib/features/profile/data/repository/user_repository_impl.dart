import 'package:clean_architecture_poktani/core/services/services_locator.dart';
import 'package:clean_architecture_poktani/features/profile/data/models/user_model.dart';
import 'package:clean_architecture_poktani/features/profile/data/source/profile_api_service.dart';
import 'package:clean_architecture_poktani/features/profile/domain/repository/user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class UserRepositoryImpl extends UserRepository {
  @override
  Future<Either> getUser() async {
    Either result = await sl<ProfileApiService>().getUser();
    return result.fold(
      (error) {
        return Left(error);
      },
      (data) async {
        Response response = data;
        var userModel = UserModel.fromMap(response.data);
        var userEntity = userModel.toEntity();
        return Right(userEntity);
      },
    );
  }
}
