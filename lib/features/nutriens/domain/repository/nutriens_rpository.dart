import 'package:clean_architecture_poktani/core/resources/data_state.dart';
import 'package:clean_architecture_poktani/features/nutriens/domain/entity/entity_response_list_of_nutriens.dart';

abstract class NutriensRepository {
  Future<DataState<NutrientResponseEntity>> getNutrients();
}
