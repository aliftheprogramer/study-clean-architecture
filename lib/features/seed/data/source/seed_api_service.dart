import 'package:clean_architecture_poktani/core/constants/api_urls.dart';
import 'package:clean_architecture_poktani/core/network/dio_client.dart';
import 'package:clean_architecture_poktani/core/resources/data_state.dart';
import 'package:clean_architecture_poktani/core/services/services_locator.dart';
import 'package:clean_architecture_poktani/features/seed/data/models/seed_list_response_model.dart';
import 'package:dio/dio.dart';

abstract class SeedApiService {
  Future<DataState<SeedListResponseModel>> getSeeds();
}

class SeedApiServiceImpl implements SeedApiService {
  @override
  Future<DataState<SeedListResponseModel>> getSeeds() async {
    try {
      final response = await sl<DioClient>().get('${ApiUrls.baseUrl}/seeds');
      final result = SeedListResponseModel.fromJson(response.data);
      return DataSuccess(data: result);
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
