import 'package:clean_architecture_poktani/core/constants/api_urls.dart';
import 'package:clean_architecture_poktani/core/network/dio_client.dart';
import 'package:clean_architecture_poktani/core/resources/data_state.dart';
import 'package:clean_architecture_poktani/core/services/services_locator.dart';
import 'package:clean_architecture_poktani/features/field/data/model/response/soil_type/respone_soil_type.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SoilTypeApiServices {
  Future<DataState<ResponseSoilTypeModel>> getSoilType();
}

class SoilTypeApiServicesImpl implements SoilTypeApiServices {
  @override
  Future<DataState<ResponseSoilTypeModel>> getSoilType() async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var token = sharedPreferences.getString('token');
      final response = await sl<DioClient>().get(
        ApiUrls.listOfSoilTypes,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        ),
      );

      final soilTypeResponse = ResponseSoilTypeModel.fromMap(response.data);
      return DataSuccess(data: soilTypeResponse);
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
