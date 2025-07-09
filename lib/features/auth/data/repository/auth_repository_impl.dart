import 'package:clean_architecture_poktani/core/resources/data_state.dart';
import 'package:clean_architecture_poktani/core/services/token_service.dart';
import 'package:clean_architecture_poktani/features/auth/data/data_sources/remote/auth_api_service.dart';
import 'package:clean_architecture_poktani/features/auth/data/models/request/login_request_model.dart';
import 'package:clean_architecture_poktani/features/auth/data/models/request/register_request_model.dart';
import 'package:clean_architecture_poktani/features/auth/domain/entities/request/login_request_entities.dart';
import 'package:clean_architecture_poktani/features/auth/domain/entities/request/register_request_entities.dart';
import 'package:clean_architecture_poktani/features/auth/domain/entities/response/auth_response_entities.dart';
import 'package:clean_architecture_poktani/features/auth/domain/repository/auth_repository.dart';
import 'package:dio/dio.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthApiService _authApiService;
  final TokenService _tokenService;
  AuthRepositoryImpl(this._authApiService, this._tokenService);

  @override
  Future<DataState<AuthResponseEntities>> login({
    required LoginEntities loginData,
  }) async {
    try {
      // Convert entities to model
      final loginRequest = LoginRequestModel(
        identifier: loginData.identifier,
        password: loginData.password,
      );

      // Call API service
      final httpResponse = await _authApiService.login(
        loginRequest: loginRequest,
      );

      if (httpResponse.response.statusCode == 200) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(
          DioException(
            requestOptions: httpResponse.response.requestOptions,
            response: httpResponse.response,
            message: 'Login failed',
          ),
        );
      }
    } on DioException catch (e) {
      return DataFailed(e);
    } catch (e) {
      return DataFailed(
        DioException(
          requestOptions: RequestOptions(path: '/auth/login'),
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Future<DataState<AuthResponseEntities>> register({
    required RegisterRequestEntities registerData,
  }) async {
    try {
      final registerRequest = RegisterRequestModel(
        name: registerData.name,
        email: registerData.email,
        password: registerData.password,
        passwordConfirmation: registerData.passwordConfirmation,
        phoneNumber: registerData.phoneNumber,
        address: registerData.address,
      );

      final httpResponse = await _authApiService.register(
        registerRequest: registerRequest,
      );

      if (httpResponse.response.statusCode == 200) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(
          DioException(
            requestOptions: httpResponse.response.requestOptions,
            response: httpResponse.response,
            message: 'Registration failed',
          ),
        );
      }
    } on DioException catch (e) {
      return DataFailed(e);
    } catch (e) {
      return DataFailed(
        DioException(
          requestOptions: RequestOptions(path: '/auth/register'),
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Future<void> saveToken(String token) async {
    await _tokenService.saveToken(token);
  }

  @override
  Future<String?> getToken() async {
    return await _tokenService.getToken();
  }

  @override
  Future<void> clearToken() async {
    await _tokenService.clearToken();
  }

  @override
  Future<bool> isLoggedIn() async {
    return await _tokenService.isLoggedIn();
  }
}
