import 'package:clean_architecture_poktani/core/services/services_locator.dart';
import 'package:clean_architecture_poktani/core/usecases/usecase.dart';
import 'package:clean_architecture_poktani/features/profile/domain/repository/user_repository.dart';
import 'package:dartz/dartz.dart';

class GetUserUseCase implements Usecase<Either, dynamic> {
  @override
  Future<Either> call({dynamic param}) async {
    return sl<UserRepository>().getUser();
  }
}
