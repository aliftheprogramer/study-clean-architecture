import 'package:clean_architecture_poktani/core/constants/api_urls.dart';
import 'package:clean_architecture_poktani/core/network/dio_client.dart';
import 'package:clean_architecture_poktani/core/resources/data_state.dart';
import 'package:clean_architecture_poktani/core/services/services_locator.dart';
import 'package:clean_architecture_poktani/features/crop/data/models/request/models_request_add_crop.dart';
import 'package:clean_architecture_poktani/features/crop/data/models/response/model_response_add_crop.dart';
import 'package:dio/dio.dart';

abstract class CropApiService {
  Future<DataState<AddCropResponseModel>> addCrop({
    required String fieldId,
    required AddCropRequestModel crop,
  });
}

class CropApiServiceImpl implements CropApiService {
  @override
  Future<DataState<AddCropResponseModel>> addCrop({
    required String fieldId,
    required AddCropRequestModel crop,
  }) async {
    try {
      final url = '${ApiUrls.detailField}/$fieldId/crops';

      final response = await sl<DioClient>().post(
        url, // Gunakan URL yang sudah dibuat
        data: crop.toJson(), // Pastikan Entity punya method toJson()
      );

      final result = AddCropResponseModel.fromJson(response.data);
      return DataSuccess(data: result);
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
