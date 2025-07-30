import 'package:clean_architecture_poktani/core/resources/data_state.dart';
import 'package:clean_architecture_poktani/features/seed/domain/entity/seed_list_response_entity.dart';

abstract class SeedRepository {
  Future<DataState<SeedListResponseEntity>> getSeeds();
}
