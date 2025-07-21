import 'package:clean_architecture_poktani/core/services/services_locator.dart';
import 'package:clean_architecture_poktani/features/profile/data/models/user_model.dart';
import 'package:clean_architecture_poktani/features/profile/data/source/profile_api_service.dart';
import 'package:clean_architecture_poktani/features/profile/domain/entities/user_entity.dart';
import 'package:clean_architecture_poktani/features/profile/domain/repository/user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class UserRepositoryImpl extends UserRepository {
  @override
  Future<Either<String, UserEntity>> getUser() async {
    try {
      final result = await sl<ProfileApiService>().getUser();
      return result.fold(
        (error) {
          return Left(error);
        },
        (response) {
          final userMap = response.data['data'];
          final userModel = UserModel.fromMap(userMap);
          return Right(userModel.toEntity());
        },
      );
    } on DioException catch (e) {
      return Left(e.response?.data['message'] ?? 'An error occurred');
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, void>> logout() async {
    try {
      await sl<ProfileApiService>().logout();
      return const Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
