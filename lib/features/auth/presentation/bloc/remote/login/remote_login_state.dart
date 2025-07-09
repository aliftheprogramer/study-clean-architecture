import 'package:clean_architecture_poktani/features/auth/domain/entities/response/auth_response_entities.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

abstract class RemoteLoginState extends Equatable {
  final AuthResponseEntities? authResponse;
  final DioException? error;

  const RemoteLoginState({this.authResponse, this.error});

  @override
  List<Object?> get props => [authResponse, error];
}

class RemoteLoginLoading extends RemoteLoginState {
  const RemoteLoginLoading();
}

class RemoteLoginSuccess extends RemoteLoginState {
  const RemoteLoginSuccess(AuthResponseEntities authResponse)
    : super(authResponse: authResponse);
}

class RemoteLoginFailure extends RemoteLoginState {
  const RemoteLoginFailure(DioException error) : super(error: error);
}
