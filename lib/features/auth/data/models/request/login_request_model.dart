import 'package:clean_architecture_poktani/features/auth/domain/entities/request/login_request_entities.dart';

class LoginRequestModel extends LoginEntities {
  const LoginRequestModel({required super.identifier, required super.password});
  factory LoginRequestModel.fromJson(Map<String, dynamic> json) {
    return LoginRequestModel(
      identifier: json['identifier'] as String,
      password: json['password'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'identifier': identifier, 'password': password};
  }
}
