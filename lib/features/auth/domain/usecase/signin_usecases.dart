import 'package:clean_architecture_poktani/core/services/services_locator.dart';
import 'package:clean_architecture_poktani/core/usecases/usecase.dart';
import 'package:clean_architecture_poktani/features/auth/data/models/login_request_model.dart';
import 'package:clean_architecture_poktani/features/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';

class SigninUsecases implements Usecase<Either, SignInReqParams> {
  @override
  Future<Either> call({SignInReqParams? param}) async {
    return sl<AuthRepository>().signIn(param!);
  }
}
