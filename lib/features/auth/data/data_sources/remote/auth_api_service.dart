import 'package:clean_architecture_poktani/core/constants/constants.dart';
import 'package:clean_architecture_poktani/features/auth/data/models/request/register_request_model.dart';
import 'package:clean_architecture_poktani/features/auth/data/models/response/auth_response_model.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import '../../models/request/login_request_model.dart';

part 'auth_api_service.g.dart';

@RestApi(baseUrl: APIBaseUrl)
abstract class AuthApiService {
  factory AuthApiService(Dio dio) = _AuthApiService;

  @POST('/auth/login')
  Future<HttpResponse<AuthResponseModel>> login({
    @Body() required LoginRequestModel loginRequest,
  });

  @POST('auth/register')
  Future<HttpResponse<AuthResponseModel>> register({
    @Body() required RegisterRequestModel registerRequest,
  });
}
