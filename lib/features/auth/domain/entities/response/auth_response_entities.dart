import 'package:equatable/equatable.dart';

class AuthResponseEntities extends Equatable {
  final String accessToken;
  final String tokenType;
  final UserEntities user;

  const AuthResponseEntities({
    required this.accessToken,
    required this.tokenType,
    required this.user,
  });

  @override
  List<Object?> get props => [accessToken, tokenType, user];
}

class UserEntities extends Equatable {
  final int id;
  final String name;
  final String? email;
  final String phoneNumber;
  final String role;
  final String address;
  final String createdAt;
  final String updatedAt;

  const UserEntities({
    required this.id,
    required this.name,
    this.email,
    required this.phoneNumber,
    required this.role,
    required this.address,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    email,
    phoneNumber,
    role,
    address,
    createdAt,
    updatedAt,
  ];
}
