import 'package:clean_architecture_poktani/core/resources/data_state.dart';
import 'package:clean_architecture_poktani/features/crop/domain/entity/request/entity_request_add_crop.dart';
import 'package:clean_architecture_poktani/features/crop/domain/entity/response/entity_response_add_crop.dart';

abstract class CropRepository {
  Future<DataState<DataCrop>> addCrop({
    String fieldId,
    EntityRequestAddCrop crop,
  });
}
