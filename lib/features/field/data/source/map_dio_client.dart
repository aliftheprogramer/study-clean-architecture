import 'package:dio/dio.dart';

// Kelas abstrak (kontrak) untuk service
abstract class GeocodingApiService {
  Future<Response> getAddress({required double lat, required double lon});
}

// Implementasi dari kontrak di atas
class GeocodingApiServiceImpl implements GeocodingApiService {
  final Dio _dio;

  GeocodingApiServiceImpl(this._dio);

  @override
  Future<Response> getAddress({
    required double lat,
    required double lon,
  }) async {
    const String baseUrl = 'https://nominatim.openstreetmap.org/reverse';
    try {
      final response = await _dio.get(
        baseUrl,
        queryParameters: {
          'format': 'jsonv2',
          'lat': lat,
          'lon': lon,
          'addressdetails': 1,
          'zoom': 18,
        },
        // User-Agent ini penting agar tidak diblokir oleh OSM
        options: Options(headers: {'User-Agent': 'AplikasiPoktani/1.0'}),
      );
      return response;
    } catch (e) {
      // Melempar kembali error agar bisa ditangkap di layer atas
      rethrow;
    }
  }
}
