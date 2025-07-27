import 'package:clean_architecture_poktani/core/resources/data_state.dart';
import 'package:clean_architecture_poktani/core/services/services_locator.dart';
import 'package:clean_architecture_poktani/features/field/data/model/request/request_add_field.dart';
import 'package:clean_architecture_poktani/features/field/data/source/field_api_services.dart';
import 'package:clean_architecture_poktani/features/field/domain/entity/request/request_add_field.dart';
import 'package:clean_architecture_poktani/features/field/domain/entity/response/field/response_add_field.dart';
import 'package:clean_architecture_poktani/features/field/domain/entity/response/field/response_list_field.dart';
import 'package:clean_architecture_poktani/features/field/domain/repository/field_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class FieldRepositoryImpl implements FieldRepository {
  @override
  Future<DataState<FieldResponseEntity>> getFields({String? url}) async {
    try {
      final httpResponse = await sl<FieldApiServices>().getFields(url: url);

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

  @override
  Future<Either<DataFailed, ResponseAddFieldEntity>> addField(
    AddFieldEntity field,
  ) async {
    try {
      final dataState = await sl<FieldApiServices>().addField(
        AddFieldRequestModel.fromEntity(field),
      );

      if (dataState is DataSuccess && dataState.data != null) {
        return Right(dataState.data!.toEntity());
      } else {
        return Left(DataFailed(dataState.error!));
      }
    } on DioException catch (e) {
      return Left(DataFailed(e));
    }
  }
}
