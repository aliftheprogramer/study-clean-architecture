import 'package:clean_architecture_poktani/core/resources/data_state.dart';
import 'package:clean_architecture_poktani/core/usecase/usecase.dart';
import 'package:clean_architecture_poktani/features/auth/domain/entities/request/login_request_entities.dart';
import 'package:clean_architecture_poktani/features/auth/domain/entities/response/auth_response_entities.dart';
import 'package:clean_architecture_poktani/features/auth/domain/repository/auth_repository.dart';

class LoginUsecase
    implements UseCase<DataState<AuthResponseEntities>, LoginEntities> {
  final AuthRepository _authRepository;

  LoginUsecase(this._authRepository);

  @override
  Future<DataState<AuthResponseEntities>> call({LoginEntities? params}) {
    if (params == null) {
      throw ArgumentError('LoginEntities params cannot be null');
    }
    return _authRepository.login(loginData: params);
  }
}