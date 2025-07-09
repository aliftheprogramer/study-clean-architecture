import 'package:equatable/equatable.dart';

class RegisterRequestEntities extends Equatable {
  final String name;
  final String email;
  final String password;
  final String passwordConfirmation;
  final String phoneNumber;
  final String address;

  const RegisterRequestEntities({
    required this.name,
    required this.email,
    required this.password,
    required this.passwordConfirmation,
    required this.phoneNumber,
    required this.address,
  });

  @override
  List<Object?> get props => [
    name,
    email,
    password,
    passwordConfirmation,
    phoneNumber,
    address,
  ];
}
