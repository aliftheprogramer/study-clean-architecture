import 'package:clean_architecture_poktani/core/resources/data_state.dart';
import 'package:clean_architecture_poktani/features/crop/domain/entity/entity_response_list_crop.dart';

abstract class CropRepository {
  Future<DataState<CropResponseEntity>> getCropList(String idField);
}
