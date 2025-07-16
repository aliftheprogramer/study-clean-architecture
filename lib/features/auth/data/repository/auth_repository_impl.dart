import 'package:clean_architecture_poktani/core/services/services_locator.dart';
import 'package:clean_architecture_poktani/features/auth/data/models/signup_req.dart';
import 'package:clean_architecture_poktani/features/auth/data/source/auth_api_service.dart';
import 'package:clean_architecture_poktani/features/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';

//semua yang ada disini diambil dari auth_repository.dart dan dalem overridenya dari source tapi ke serices_locator.dart dulu
class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<Either> signUp(SignupReqParams signUpReqParams) async {
    return sl<AuthApiService>().signUp(signUpReqParams);
  }
}
