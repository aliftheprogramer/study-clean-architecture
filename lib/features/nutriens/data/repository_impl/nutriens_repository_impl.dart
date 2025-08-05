import 'package:clean_architecture_poktani/core/resources/data_state.dart';
import 'package:clean_architecture_poktani/features/nutriens/domain/entity/entity_response_list_of_nutriens.dart';
import 'package:clean_architecture_poktani/features/nutriens/domain/repository/nutriens_rpository.dart';

class NutriensRepositoryImpl implements NutriensRepository{
  @override
  Future<DataState<NutrientResponseEntity>> getNutrients() {
    // TODO: implement getNutrients
    throw UnimplementedError();
  }
}