import 'package:clean_architecture_poktani/features/auth/data/models/signup_req.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either> signUp(SignupReqParams signUpReqParams);
}
