import 'package:clean_architecture_poktani/core/resources/data_state.dart';
import 'package:clean_architecture_poktani/features/field/domain/entity/response/response_address_detail_entity.dart';

abstract class GeocodingRepository {
  Future<DataState<AddressDetailEntity>> getAddressFromCoordinates({
    required double lat,
    required double lon,
  });
}
