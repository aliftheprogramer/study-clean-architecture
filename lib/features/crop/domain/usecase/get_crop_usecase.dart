import 'package:clean_architecture_poktani/core/resources/data_state.dart';
import 'package:clean_architecture_poktani/core/services/services_locator.dart';
import 'package:clean_architecture_poktani/core/usecases/usecase.dart';
import 'package:clean_architecture_poktani/features/crop/domain/entity/entity_response_list_crop.dart';
import 'package:clean_architecture_poktani/features/crop/domain/repository/crop_repository.dart';

class GetCropUsecase implements Usecase<DataState<CropResponseEntity>, String> {
  @override
  Future<DataState<CropResponseEntity>> call({String? param}) {
    return sl<CropRepository>().getCropList(param!);
  }
}
