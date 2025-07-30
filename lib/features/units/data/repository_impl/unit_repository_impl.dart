import 'package:clean_architecture_poktani/core/resources/data_state.dart';
import 'package:clean_architecture_poktani/core/services/services_locator.dart';
import 'package:clean_architecture_poktani/features/units/data/source/unit_api_service.dart';
import 'package:clean_architecture_poktani/features/units/domain/entity/unit_list_response_entity.dart';
import 'package:clean_architecture_poktani/features/units/domain/repository/unit_repository.dart';
import 'package:dio/dio.dart';

class UnitRepositoryImpl implements UnitRepository {
  @override
  Future<DataState<UnitListResponseEntity>> getUnits() async {
    try {
      final dataState = await sl<UnitApiService>().getUnits();
      if (dataState is DataSuccess && dataState.data != null) {
        return DataSuccess(data: dataState.data!.toEntity());
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
