import 'package:clean_architecture_poktani/core/resources/data_state.dart';

import 'package:clean_architecture_poktani/features/auth/domain/entities/request/login_request_entities.dart';
import 'package:clean_architecture_poktani/features/auth/domain/entities/request/register_request_entities.dart';
import 'package:clean_architecture_poktani/features/auth/domain/entities/response/auth_response_entities.dart';

abstract class AuthRepository {
  Future<DataState<AuthResponseEntities>> login({
    required LoginEntities loginData,
  });

  Future<DataState<AuthResponseEntities>> register({
    required RegisterRequestEntities registerData,
  });

  Future<void> saveToken(String token);
  Future<String?> getToken();
  Future<void> clearToken();
  Future<bool> isLoggedIn();
}
