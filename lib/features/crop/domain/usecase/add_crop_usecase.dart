import 'package:clean_architecture_poktani/core/resources/data_state.dart';
import 'package:clean_architecture_poktani/core/services/services_locator.dart';
import 'package:clean_architecture_poktani/core/usecases/usecase.dart';
import 'package:clean_architecture_poktani/features/crop/domain/entity/response/entity_response_add_crop.dart';
import 'package:clean_architecture_poktani/features/crop/domain/repository/crop_repository.dart';
import 'package:clean_architecture_poktani/features/crop/domain/usecase/params/add_crop_params.dart';

class AddCropUsecase implements Usecase<DataState<DataCrop>, AddCropParams> {
  @override
  Future<DataState<DataCrop>> call({AddCropParams? param}) async {
    // Teruskan kedua parameter ke repository
    return await sl<CropRepository>().addCrop(
      fieldId: param!.fieldId,
      crop: param.crop,
    );
  }
}
