import 'package:clean_architecture_poktani/features/map/data/source/geocoding_api_services.dart';
import 'package:clean_architecture_poktani/core/resources/data_state.dart';
import 'package:clean_architecture_poktani/core/services/services_locator.dart';
import 'package:clean_architecture_poktani/features/map/data/model/response_map_model.dart';
import 'package:clean_architecture_poktani/features/field/domain/entity/response/field/response_address_detail_entity.dart';
import 'package:clean_architecture_poktani/features/map/domain/repository/map_repository.dart';
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
      final nominatimModel = NominatimResponseModel.fromMap(response.data);
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
      latitude: (lat ?? 0.0),
      longitude: (lon ?? 0.0),
      hamlet:
          address?.hamlet ??
          address?.hamlet ??
          address?.suburb ??
          address?.road ??
          address?.village,
      village: address?.village,
      city_district:
          address?.suburb ?? address?.city_district ?? address?.municipality,
      state: address?.state,
    );
  }
}
