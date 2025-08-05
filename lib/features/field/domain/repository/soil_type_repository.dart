import 'package:clean_architecture_poktani/core/resources/data_state.dart';
import 'package:clean_architecture_poktani/features/field/domain/entity/response/soil_type/response_soil_type_entitiy.dart';

abstract class SoilTypeRepository {
  Future<DataState<ResponseSoilTypeEntitiy>> getSoilType();
}
