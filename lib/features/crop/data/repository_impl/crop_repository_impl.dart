import 'package:clean_architecture_poktani/core/resources/data_state.dart';
import 'package:clean_architecture_poktani/features/crop/domain/entity/entity_response_list_crop.dart';
import 'package:clean_architecture_poktani/features/crop/domain/repository/crop_repository.dart';

class CropRepositoryImpl implements CropRepository {
  @override
  Future<DataState<CropResponseEntity>> getCropList(String idField) {
    // TODO: implement getCropList
    throw UnimplementedError();
  }
}
