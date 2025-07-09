import 'package:clean_architecture_poktani/features/auth/domain/entities/response/auth_response_entities.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

abstract class RemoteRegisterState extends Equatable {
  final AuthResponseEntities? authResponse;
  final DioException? error;

  const RemoteRegisterState({this.authResponse, this.error});

  @override
  List<Object?> get props => [authResponse, error];
}

class RemoteRegisterLoading extends RemoteRegisterState {
  const RemoteRegisterLoading();
}

class RemoteRegisterSuccess extends RemoteRegisterState {
  const RemoteRegisterSuccess(AuthResponseEntities authResponse)
    : super(authResponse: authResponse);
}

class RemoteRegisterFailure extends RemoteRegisterState {
  const RemoteRegisterFailure(DioException error) : super(error: error);
}
