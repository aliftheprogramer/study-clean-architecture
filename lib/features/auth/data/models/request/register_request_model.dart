import 'package:clean_architecture_poktani/features/auth/domain/entities/request/register_request_entities.dart';

class RegisterRequestModel extends RegisterRequestEntities {
  const RegisterRequestModel({
    required super.name,
    required super.email,
    required super.password,
    required super.passwordConfirmation,
    required super.phoneNumber,
    required super.address,
  });

  factory RegisterRequestModel.fromJson(Map<String, dynamic> json) {
    return RegisterRequestModel(
      name: json['name'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      passwordConfirmation: json['password_confirmation'] as String,
      phoneNumber: json['phone_number'] as String,
      address: json['address'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'password_confirmation': passwordConfirmation,
      'phone_number': phoneNumber,
      'address': address,
    };
  }
}
