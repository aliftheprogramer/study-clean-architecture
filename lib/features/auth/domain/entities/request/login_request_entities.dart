import 'package:equatable/equatable.dart';

class LoginEntities extends Equatable {
  final String identifier;
  final String password;

  const LoginEntities({required this.identifier, required this.password});

  @override
  List<Object?> get props => [identifier, password];
}
