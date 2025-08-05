import 'package:clean_architecture_poktani/core/resources/data_state.dart';
import 'package:clean_architecture_poktani/core/services/services_locator.dart';
import 'package:clean_architecture_poktani/features/field/data/source/soil_type_api_services.dart';
import 'package:clean_architecture_poktani/features/field/domain/entity/response/soil_type/response_soil_type_entitiy.dart';
import 'package:clean_architecture_poktani/features/field/domain/repository/soil_type_repository.dart';
import 'package:dio/dio.dart';

class SoilTypeRepositoryImpl implements SoilTypeRepository {
  @override
  Future<DataState<ResponseSoilTypeEntitiy>> getSoilType() async {
    try {
      final httpResponse = await sl<SoilTypeApiServices>().getSoilType();

      if (httpResponse.data != null) {
        return DataSuccess(data: httpResponse.data!.toEntity());
      } else {
        return DataFailed(
          httpResponse.error ??
              DioException(requestOptions: RequestOptions(path: '')),
        );
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
