import 'package:clean_architecture_poktani/core/services/services_locator.dart';
import 'package:clean_architecture_poktani/core/usecases/usecase.dart';
import 'package:clean_architecture_poktani/features/auth/data/models/signup_req.dart';
import 'package:clean_architecture_poktani/features/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';

class SignupUsecase implements Usecase<Either, SignupReqParams> {
  @override
  Future<Either> call({SignupReqParams? param}) async {
    return sl<AuthRepository>().signUp(param!);
  }
}
