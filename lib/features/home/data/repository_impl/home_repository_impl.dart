import 'package:clean_architecture_poktani/core/resources/data_state.dart';
import 'package:clean_architecture_poktani/core/services/services_locator.dart';
import 'package:clean_architecture_poktani/features/home/data/source/home_api_services.dart';
import 'package:clean_architecture_poktani/features/home/domain/entity/field.dart';
import 'package:clean_architecture_poktani/features/home/domain/repository/home_repositoy.dart';
import 'package:dio/dio.dart';

class HomeRepositoryImpl implements HomeRepository {
  @override
  Future<DataState<ResponseListFieldHomeEntity>> getFields() async {
    final httpResponse = await sl<HomeApiServices>().getFields();

    if (httpResponse.data != null) {
      return DataSuccess(data: httpResponse.data!.toEntity());
    } else {
      return DataFailed(
        httpResponse.error ??
            DioException(requestOptions: RequestOptions(path: '')),
      );
    }
  }
}
