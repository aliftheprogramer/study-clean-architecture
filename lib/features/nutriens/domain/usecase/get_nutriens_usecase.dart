import 'package:clean_architecture_poktani/core/resources/data_state.dart';
import 'package:clean_architecture_poktani/core/services/services_locator.dart';
import 'package:clean_architecture_poktani/core/usecases/usecase.dart';
import 'package:clean_architecture_poktani/features/nutriens/domain/entity/entity_response_list_of_nutriens.dart';
import 'package:clean_architecture_poktani/features/nutriens/domain/repository/nutriens_rpository.dart';

class GetNutriensUsecase
    implements Usecase<DataState<NutrientResponseEntity>, String> {
  @override
  Future<DataState<NutrientResponseEntity>> call({String? param}) {
    return sl<NutriensRepository>().getNutrients();
  }
}
