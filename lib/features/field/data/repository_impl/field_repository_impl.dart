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
  Future<Either<DataFailed, ResponseAddFieldEntity>> addField(
    AddFieldEntity field,
  ) async {
    try {
      // 1. Dapatkan respons mentah (raw http response) dari API Service
      final httpResponse = await sl<FieldApiServices>().addField(
        AddFieldRequestModel.fromEntity(field),
      );

      // 2. Cek jika body respons tidak null
      if (httpResponse.data != null) {
        // 3. Buka "kotak" JSON dan ambil nested object 'data'
        final dataJson = httpResponse.data as Map<String, dynamic>;

        // 4. Parsing nested object itu menjadi Model kita
        final resultModel = ResponseAddFieldsModel.fromMap(dataJson);

        // 5. Ubah Model ke Entity dan return sebagai tanda sukses (Right)
        return Right(resultModel.toEntity());
      } else {
        // Handle jika respons dari server tidak memiliki body/data
        return Left(
          DataFailed(
            DioException(
              requestOptions: RequestOptions(path: ''),
              message: 'Respons dari server kosong.',
            ),
          ),
        );
      }
    } on DioException catch (e) {
      // Handle jika ada error dari Dio (jaringan, status code 4xx/5xx)
      return Left(DataFailed(e));
    } catch (e) {
      // Handle jika ada error lain (misalnya, parsing gagal)
      return Left(
        DataFailed(
          DioException(
            requestOptions: RequestOptions(path: ''),
            message: 'Terjadi kesalahan tidak dikenal: $e',
          ),
        ),
      );
    }
  }
}
