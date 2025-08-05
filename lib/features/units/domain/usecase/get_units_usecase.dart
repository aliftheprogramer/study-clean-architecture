import 'package:clean_architecture_poktani/core/resources/data_state.dart';
import 'package:clean_architecture_poktani/core/services/services_locator.dart';
import 'package:clean_architecture_poktani/core/usecases/usecase.dart';
import 'package:clean_architecture_poktani/features/units/domain/entity/unit_list_response_entity.dart';
import 'package:clean_architecture_poktani/features/units/domain/repository/unit_repository.dart';

class GetUnitsUseCase
    implements Usecase<DataState<UnitListResponseEntity>, void> {
  @override
  Future<DataState<UnitListResponseEntity>> call({void param}) async {
    return await sl<UnitRepository>().getUnits();
  }
}
