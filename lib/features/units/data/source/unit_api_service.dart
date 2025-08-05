import 'package:clean_architecture_poktani/core/constants/api_urls.dart';
import 'package:clean_architecture_poktani/core/network/dio_client.dart';
import 'package:clean_architecture_poktani/core/resources/data_state.dart';
import 'package:clean_architecture_poktani/core/services/services_locator.dart';
import 'package:clean_architecture_poktani/features/units/data/models/unit_list_response_model.dart';
import 'package:dio/dio.dart';

abstract class UnitApiService {
  Future<DataState<UnitListResponseModel>> getUnits();
}

class UnitApiServiceImpl implements UnitApiService {
  @override
  Future<DataState<UnitListResponseModel>> getUnits() async {
    try {
      final response = await sl<DioClient>().get(ApiUrls.listOfUnits);
      final result = UnitListResponseModel.fromJson(response.data);
      return DataSuccess(data: result);
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
