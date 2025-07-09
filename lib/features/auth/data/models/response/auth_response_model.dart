import 'package:clean_architecture_poktani/features/auth/domain/entities/response/auth_response_entities.dart';

class AuthResponseModel extends AuthResponseEntities {
  const AuthResponseModel({
    required super.accessToken,
    required super.tokenType,
    required super.user,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(
      accessToken: json['access_token'] as String,
      tokenType: json['token_type'] as String,
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      'token_type': tokenType,
      'user': (user as UserModel).toJson(),
    };
  }
}

class UserModel extends UserEntities {
  const UserModel({
    required super.id,
    required super.name,
    super.email,
    required super.phoneNumber,
    required super.role,
    required super.address,
    required super.createdAt,
    required super.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String?,
      phoneNumber: json['phone_number'] as String,
      role: json['role'] as String,
      address: json['address'] as String,
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone_number': phoneNumber,
      'role': role,
      'address': address,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
