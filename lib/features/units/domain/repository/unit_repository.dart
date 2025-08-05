import 'package:clean_architecture_poktani/core/resources/data_state.dart';
import 'package:clean_architecture_poktani/features/units/domain/entity/unit_list_response_entity.dart';

abstract class UnitRepository {
  Future<DataState<UnitListResponseEntity>> getUnits();
}
