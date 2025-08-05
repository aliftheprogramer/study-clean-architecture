import 'package:clean_architecture_poktani/core/resources/data_state.dart';
import 'package:clean_architecture_poktani/core/services/services_locator.dart';
import 'package:clean_architecture_poktani/features/seed/data/source/seed_api_service.dart';
import 'package:clean_architecture_poktani/features/seed/domain/entity/seed_list_response_entity.dart';
import 'package:clean_architecture_poktani/features/seed/domain/repository/seed_repository.dart';
import 'package:dio/dio.dart';

class SeedRepositoryImpl implements SeedRepository {
  @override
  Future<DataState<SeedListResponseEntity>> getSeeds() async {
    try {
      final dataState = await sl<SeedApiService>().getSeeds();
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
