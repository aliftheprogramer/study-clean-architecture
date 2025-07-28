// file: features/home/data/source/home_api_services.dart

import 'package:clean_architecture_poktani/core/constants/api_urls.dart';
import 'package:clean_architecture_poktani/core/network/dio_client.dart';
import 'package:clean_architecture_poktani/core/resources/data_state.dart';
import 'package:clean_architecture_poktani/core/services/services_locator.dart';
import 'package:clean_architecture_poktani/features/home/data/model/list_field_response_model_home.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class HomeApiServices {
  // Ubah parameter dari 'url' menjadi 'cursor'
  Future<DataState<ResponseListFieldHomeModel>> getFields({String? cursor});
}

class HomeApiServicesImpl implements HomeApiServices {
  @override
  // Parameter di sini juga berubah menjadi 'cursor'
  Future<DataState<ResponseListFieldHomeModel>> getFields({
    String? cursor,
  }) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var token = sharedPreferences.getString('token');

      // 1. Siapkan map untuk menampung semua query parameter
      final Map<String, dynamic> queryParameters = {'per_page': 5};

      // 2. Jika ada cursor (untuk halaman 2, 3, dst.), tambahkan ke map
      if (cursor != null && cursor.isNotEmpty) {
        queryParameters['cursor'] = cursor;
      }

      // 3. Selalu panggil endpoint dasar dengan parameter yang sudah dibangun
      final response = await sl<DioClient>().get(
        ApiUrls.listOfFields, // Selalu endpoint dasar
        queryParameters: queryParameters, // Kirim map yang dinamis
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        ),
      );

      final fieldResponse = ResponseListFieldHomeModel.fromMap(response.data);
      return DataSuccess(data: fieldResponse);
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
