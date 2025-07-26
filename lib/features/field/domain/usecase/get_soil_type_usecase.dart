import 'package:clean_architecture_poktani/core/resources/data_state.dart';
import 'package:clean_architecture_poktani/core/services/services_locator.dart';
import 'package:clean_architecture_poktani/core/usecases/usecase.dart';
import 'package:clean_architecture_poktani/features/field/domain/entity/response/soil_type/response_soil_type_entitiy.dart';
import 'package:clean_architecture_poktani/features/field/domain/repository/soil_type_repository.dart';

class GetSoilTypeUsecase
    implements Usecase<DataState<ResponseSoilTypeEntitiy>, String> {
  @override
  Future<DataState<ResponseSoilTypeEntitiy>> call({String? param}) {
    return sl<SoilTypeRepository>().getSoilType();
  }
}
