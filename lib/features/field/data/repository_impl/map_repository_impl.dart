import 'package:clean_architecture_poktani/features/field/data/source/map_dio_client.dart';
import 'package:clean_architecture_poktani/core/resources/data_state.dart';
import 'package:clean_architecture_poktani/core/services/services_locator.dart';
import 'package:clean_architecture_poktani/features/field/data/model/response/response_map_model.dart';
import 'package:clean_architecture_poktani/features/field/domain/entity/response/response_address_detail_entity.dart';
import 'package:clean_architecture_poktani/features/field/domain/repository/map_repository.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class GeocodingRepositoryImpl implements GeocodingRepository {
  @override
  Future<DataState<AddressDetailEntity>> getAddressFromCoordinates({
    required double lat,
    required double lon,
  }) async {
    try {
      final response = await sl<GeocodingApiService>().getAddress(
        lat: lat,
        lon: lon,
      );
      Logger().i(response);
      // Parsing JSON ke Model
      final nominatimModel = NominatimResponseModel.fromMap(response.data);
      // Konversi Model ke Entity
      Logger().i('Response data: ${response.data}');
      return DataSuccess(data: nominatimModel.toEntity());
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}

extension on NominatimResponseModel {
  AddressDetailEntity toEntity() {
    return AddressDetailEntity(
      // Pastikan ada nilai default jika data dari API null
      latitude: (lat ?? 0.0),
      longitude: (lon ?? 0.0),
      road: address?.road,
      amenity: address?.amenity,
      village: address?.village,
      subdistrict: address?.subdistrict,
      city: address?.city,
      state: address?.state,
    );
  }
}
