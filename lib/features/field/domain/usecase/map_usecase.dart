import 'package:clean_architecture_poktani/core/resources/data_state.dart';
import 'package:clean_architecture_poktani/features/field/domain/entity/response/response_address_detail_entity.dart';
import 'package:clean_architecture_poktani/features/field/domain/repository/map_repository.dart';

class GetAddressFromCoordinatesUseCase {
  final GeocodingRepository _repository;

  GetAddressFromCoordinatesUseCase(this._repository);

  Future<DataState<AddressDetailEntity>> call({
    required double lat,
    required double lon,
  }) {
    return _repository.getAddressFromCoordinates(lat: lat, lon: lon);
  }
}
