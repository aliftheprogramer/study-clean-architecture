import 'package:clean_architecture_poktani/core/resources/data_state.dart';
import 'package:clean_architecture_poktani/core/services/services_locator.dart';
import 'package:clean_architecture_poktani/features/crop/data/models/request/models_request_add_crop.dart';
import 'package:clean_architecture_poktani/features/crop/data/source/crop_api_service.dart';
import 'package:clean_architecture_poktani/features/crop/domain/entity/request/entity_request_add_crop.dart';
import 'package:clean_architecture_poktani/features/crop/domain/entity/response/entity_response_add_crop.dart';
import 'package:clean_architecture_poktani/features/crop/domain/repository/crop_repository.dart';
import 'package:dio/dio.dart';

class CropRepositoryImpl implements CropRepository {
  @override
  Future<DataState<DataCrop>> addCrop({
    String? fieldId,
    EntityRequestAddCrop? crop,
  }) async {
    try {
      final dataState = await sl<CropApiService>().addCrop(
        fieldId: fieldId!,
        crop: AddCropRequestModel.fromEntity(crop!),
      );
      if (dataState is DataSuccess) {
        return DataSuccess(data: dataState.data!.toEntity().data);
      } else if (dataState is DataFailed) {
        return DataFailed(dataState.error!);
      } else {
        return DataFailed(
          DioException(requestOptions: RequestOptions(path: '')),
        );
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
