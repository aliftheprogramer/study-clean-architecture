import 'package:clean_architecture_poktani/features/crop/domain/usecase/add_crop_usecase.dart';
import 'package:clean_architecture_poktani/features/crop/domain/usecase/params/add_crop_params.dart';
import 'package:clean_architecture_poktani/features/crop/presentation/bloc/add_crop_state.dart';
import 'package:clean_architecture_poktani/core/resources/data_state.dart';
import 'package:clean_architecture_poktani/features/crop/domain/entity/request/entity_request_add_crop.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddCropCubit extends Cubit<AddCropState> {
  final AddCropUsecase _addCropUsecase;

  AddCropCubit(this._addCropUsecase) : super(AddCropInitial());

  Future<void> addCrop({
    required String fieldId,
    required EntityRequestAddCrop cropData,
  }) async {
    emit(AddCropLoading());

    final params = AddCropParams(fieldId: fieldId, crop: cropData);

    final result = await _addCropUsecase(param: params);

    if (result is DataSuccess && result.data != null) {
      emit(AddCropSuccess(result.data!));
    } else if (result is DataFailed) {
      emit(
        AddCropFailure(
          result.error?.message ?? 'Terjadi kesalahan tidak diketahui',
        ),
      );
    }
  }
}
