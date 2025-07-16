import 'package:clean_architecture_poktani/features/auth/domain/entities/request/register/register_data.dart';

abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {
  final RegisterData registerData;
  RegisterSuccess({required this.registerData});
}

class RegisterFailure extends RegisterState {
  final String errorMessage;
  RegisterFailure({required this.errorMessage});
}
