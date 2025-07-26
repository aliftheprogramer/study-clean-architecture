import 'package:clean_architecture_poktani/core/resources/data_state.dart';
import 'package:clean_architecture_poktani/core/services/services_locator.dart';
import 'package:clean_architecture_poktani/features/field/data/model/request/request_add_field.dart';
import 'package:clean_architecture_poktani/features/field/data/model/response/field/response_add_fields_model.dart';
import 'package:clean_architecture_poktani/features/field/data/model/response/field/response_list_fields_model.dart';
import 'package:clean_architecture_poktani/features/field/data/source/field_api_services.dart';
import 'package:clean_architecture_poktani/features/field/domain/entity/list_field_entity.dart';
import 'package:clean_architecture_poktani/features/field/domain/entity/request/request_add_field.dart';
import 'package:clean_architecture_poktani/features/field/domain/entity/response/field/response_add_field.dart';
import 'package:clean_architecture_poktani/features/field/domain/entity/response/field/response_list_field.dart';
import 'package:clean_architecture_poktani/features/field/domain/repository/field_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  Future<Either<DataFailed, ResponseAddField>> addField(
    AddFieldEntity field,
  ) async {
    try {
      final fieldModel = AddFieldRequestModel.fromEntity(field);
      final dataState = await sl<FieldApiServices>().addField(fieldModel);
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

extension on ResponseAddFieldsModel {
  ResponseAddField toEntity() {
    return ResponseAddField(
      id: this.id,
      name: name,
      landArea: land_area,
      pictureUrl: 'rawr.png',
      address: address.toEntity(),
      soilType: soil_type,
      activeCrop: active_crop?.toEntity(),
    );
  }
}
