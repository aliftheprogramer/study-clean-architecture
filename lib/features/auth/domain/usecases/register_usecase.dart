import 'package:clean_architecture_poktani/core/resources/data_state.dart';
import 'package:clean_architecture_poktani/core/usecase/usecase.dart';
import 'package:clean_architecture_poktani/features/auth/domain/entities/request/register_request_entities.dart';

import 'package:clean_architecture_poktani/features/auth/domain/repository/auth_repository.dart';
import '../entities/response/auth_response_entities.dart';

class RegisterUsecase
    implements
        UseCase<DataState<AuthResponseEntities>, RegisterRequestEntities> {
  final AuthRepository _authRepository;

  RegisterUsecase(this._authRepository);
  @override
  Future<DataState<AuthResponseEntities>> call({
    RegisterRequestEntities? params,
  }) {
    if (params == null) {
      throw ArgumentError('Register parameters cannot be null');
    }
    return _authRepository.register(registerData: params);
  }
}
