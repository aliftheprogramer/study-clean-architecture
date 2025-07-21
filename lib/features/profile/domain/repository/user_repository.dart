import 'package:dartz/dartz.dart';

abstract class UserRepository {
  Future<Either> getUser();
  Future<Either<String, void>> logout();
}
