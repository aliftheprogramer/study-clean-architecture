import 'package:clean_architecture_poktani/core/constants/api_urls.dart';
import 'package:clean_architecture_poktani/core/network/dio_client.dart';
import 'package:clean_architecture_poktani/core/resources/data_state.dart';
import 'package:clean_architecture_poktani/core/services/services_locator.dart';
import 'package:clean_architecture_poktani/features/field/data/model/request/request_add_field.dart';
import 'package:clean_architecture_poktani/features/field/data/model/response/response_add_fields_model.dart';
import 'package:clean_architecture_poktani/features/field/data/model/response/response_list_fields_model.dart';
import 'package:clean_architecture_poktani/features/field/domain/entity/request/request_add_field.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class FieldApiServices {
  Future<DataState<ResponseListFieldsModel>> getFields({String? url});
  Future<DataState<ResponseAddFieldsModel>> addField(AddFieldEntity field);
}

class FieldApiServicesImpl implements FieldApiServices {
  @override
  Future<DataState<ResponseListFieldsModel>> getFields({String? url}) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var token = sharedPreferences.getString('token');
      final endPoint = url ?? ApiUrls.listOfFields;
      final queryParameters = url == null ? {'per_page': 5} : null;
      var response = await sl<DioClient>().get(
        endPoint,
        queryParameters: queryParameters,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        ),
      );
      final fieldResponse = ResponseListFieldsModel.fromMap(response.data);
      return DataSuccess(data: fieldResponse);
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<ResponseAddFieldsModel>> addField(
    AddFieldEntity field, // 1. Ubah parameter menjadi AddFieldEntity
  ) async {
    try {
      // Buat objek Model dari Entity yang diterima
      final model = AddFieldRequestModel.fromEntity(field);

      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var token = sharedPreferences.getString('token');

      final response = await sl<DioClient>().post(
        ApiUrls.addField,
        data: model.toJson(), // Gunakan model yang sudah dikonversi ke JSON
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        ),
      );

      // 2. Gunakan ResponseAddFieldsModel untuk mem-parsing data
      final fieldResponse = ResponseAddFieldsModel.fromMap(response.data);

      // 3. Kembalikan DataSuccess dengan tipe yang benar
      return DataSuccess(data: fieldResponse);
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
