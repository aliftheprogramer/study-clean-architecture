import 'package:clean_architecture_poktani/core/network/map_dio_lient.dart';
import 'package:dio/dio.dart';
import 'package:clean_architecture_poktani/core/services/services_locator.dart'; // <-- IMPORT GetIt

// Kelas abstrak (kontrak) tidak perlu diubah
abstract class GeocodingApiService {
  Future<Response> getAddress({required double lat, required double lon});
}

// Implementasi dari kontrak yang sudah diubah
class GeocodingApiServiceImpl implements GeocodingApiService {
  // Ambil MapDioClient yang sudah kita daftarkan di GetIt (sl)
  final MapDioClient _mapDioClient = sl<MapDioClient>();

  // Constructor yang menerima Dio tidak diperlukan lagi

  @override
  Future<Response> getAddress({
    required double lat,
    required double lon,
  }) async {
    try {
      // Panggil method get dari _mapDioClient
      // Endpoint-nya cukup '/reverse' karena baseUrl sudah diatur di dalam MapDioClient
      final response = await _mapDioClient.get(
        '/reverse',
        queryParameters: {
          'format': 'jsonv2',
          'lat': lat,
          'lon': lon,
          'addressdetails': 1,
          'zoom': 18,
        },
        // 'options' berisi header tidak perlu lagi, karena sudah diatur di dalam MapDioClient
      );
      return response;
    } catch (e) {
      // Melempar kembali error agar bisa ditangkap di layer atas
      rethrow;
    }
  }
}
