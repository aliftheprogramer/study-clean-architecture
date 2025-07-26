import 'package:dio/dio.dart';

// Asumsi file interceptors.dart bisa diakses dari sini
import 'package:clean_architecture_poktani/core/network/interceptors.dart';

class MapDioClient {
  late final Dio _dio;

  MapDioClient()
    : _dio = Dio(
        BaseOptions(
          baseUrl: 'https://nominatim.openstreetmap.org',
          headers: {
            'User-Agent': 'AplikasiPoktani/1.0', // Header penting
            'Content-Type': 'application/json; charset=UTF-8',
          },
          responseType: ResponseType.json,
        ),
      )..interceptors.addAll([LoggerInterceptor()]);

  // Kita hanya butuh method GET untuk peta, jadi cukup salin yang ini
  Future<Response> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final Response response = await _dio.get(
        url,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } on DioException {
      rethrow;
    }
  }
}
