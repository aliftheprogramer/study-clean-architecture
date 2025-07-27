import 'package:clean_architecture_poktani/core/constants/api_urls.dart';
import 'package:clean_architecture_poktani/core/network/dio_client.dart';
import 'package:clean_architecture_poktani/core/resources/data_state.dart';
import 'package:clean_architecture_poktani/core/services/services_locator.dart';
import 'package:clean_architecture_poktani/features/home/data/model/list_field_response_model_home.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class HomeApiServices {
  Future<DataState<ResponseListFieldHomeModel>> getFields({String? url});
}

class HomeApiServicesImpl implements HomeApiServices {
  @override
  Future<DataState<ResponseListFieldHomeModel>> getFields({String? url}) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();

      var token = sharedPreferences.getString('token');
      final endPoint = url ?? ApiUrls.listOfFields;
      final queryParameters = url == null ? {'per_page': 5} : null;
      var response = await sl<DioClient>().get(
        endPoint,
        queryParameters: queryParameters,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        ),
      );

      final fieldResponse = ResponseListFieldHomeModel.fromMap(response.data);
      return DataSuccess(data: fieldResponse);
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
