import 'package:clean_architecture_poktani/features/auth/data/models/login_request_model.dart';
import 'package:clean_architecture_poktani/features/auth/data/models/signup_req.dart';
import 'package:clean_architecture_poktani/features/auth/domain/entities/request/register/login_entities.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either> signUp(SignupReqParams signUpReqParams);
  Future<Either> signIn(SignInReqParams signInReqParams);
  Future<bool> isLoggedIn();
}
