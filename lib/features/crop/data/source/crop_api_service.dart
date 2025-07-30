import 'package:clean_architecture_poktani/core/constants/api_urls.dart';
import 'package:clean_architecture_poktani/core/network/dio_client.dart';
import 'package:clean_architecture_poktani/core/resources/data_state.dart';
import 'package:clean_architecture_poktani/core/services/services_locator.dart';
import 'package:clean_architecture_poktani/features/crop/data/models/response/model_response_list_crop.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class CropApiService {
  Future<DataState<ModelResponseListCrop>> getCropList(String idField);
}

class CropApiServiceImpl implements CropApiService {
  @override
  Future<DataState<ModelResponseListCrop>> getCropList(String idField) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var token = sharedPreferences.getString('token');
      final url = "${ApiUrls.detailField}/$idField/crops";
      final response = await sl<DioClient>().get(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        ),
      );
      final cropResponse = ModelResponseListCrop.fromMap(response.data);
      return DataSuccess(data: cropResponse);
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
