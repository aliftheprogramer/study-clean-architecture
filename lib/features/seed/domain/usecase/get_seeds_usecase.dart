import 'package:clean_architecture_poktani/core/resources/data_state.dart';
import 'package:clean_architecture_poktani/core/services/services_locator.dart';
import 'package:clean_architecture_poktani/core/usecases/usecase.dart';
import 'package:clean_architecture_poktani/features/seed/domain/entity/seed_list_response_entity.dart';
import 'package:clean_architecture_poktani/features/seed/domain/repository/seed_repository.dart';

class GetSeedsUseCase
    implements Usecase<DataState<SeedListResponseEntity>, void> {
  @override
  Future<DataState<SeedListResponseEntity>> call({void param}) async {
    return await sl<SeedRepository>().getSeeds();
  }
}
