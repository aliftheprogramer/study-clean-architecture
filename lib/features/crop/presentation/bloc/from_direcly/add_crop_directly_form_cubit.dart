import 'package:clean_architecture_poktani/features/crop/presentation/bloc/from_direcly/add_crop_directly_dorm_state.dart';
import 'package:clean_architecture_poktani/features/seed/domain/entity/seed_list_response_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddCropDirectlyFormCubit extends Cubit<AddCropDirectlyFormState> {
  AddCropDirectlyFormCubit() : super(const AddCropDirectlyFormState());

  void seedChanged(SeedEntity seed) {
    emit(state.copyWith(selectedSeed: seed));
  }

  void dateChanged(DateTime date) {
    emit(state.copyWith(selectedDate: date));
  }

  void quantityChanged(String quantity) {
    emit(state.copyWith(plantQuantity: quantity));
  }

  void coordinatorIdChanged(String id) {
    emit(state.copyWith(fieldCoordinatorId: id));
  }
}
