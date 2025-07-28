import 'package:clean_architecture_poktani/core/resources/data_state.dart';
import 'package:clean_architecture_poktani/core/services/services_locator.dart';
import 'package:clean_architecture_poktani/features/home/data/source/home_api_services.dart';
import 'package:clean_architecture_poktani/features/home/domain/entity/field.dart';
import 'package:clean_architecture_poktani/features/home/domain/repository/home_repositoy.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class HomeRepositoryImpl implements HomeRepository {
  @override
  Future<DataState<ResponseListFieldHomeEntity>> getFields({
    String? cursor,
  }) async {
    final httpResponse = await sl<HomeApiServices>().getFields(cursor: cursor);

    if (httpResponse.data != null) {
      Logger().i(
        'Fields fetched successfully: ${httpResponse.data} file repo impl',
      );
      return DataSuccess(data: httpResponse.data!.toEntity());
    } else {
      return DataFailed(
        httpResponse.error ??
            DioException(requestOptions: RequestOptions(path: '')),
      );
    }
  }
}
