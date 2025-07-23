import 'package:clean_architecture_poktani/features/field/domain/entity/list_field_entity.dart';
import 'package:clean_architecture_poktani/features/field/presentation/list_field/bloc/field_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListFieldCubit extends Cubit<ListFieldState> {
  final List<ListFieldEntity> _dummyListFields = dummyListFields;

  ListFieldCubit() : super(ListFieldInitialState());

  Future<void> loadListFields() async {
    try {
      if (dummyListFields.isEmpty) {
        emit(ListFieldEmptyState("No fields available"));
        return;
      }
      emit(ListFieldLoadingState());
      await Future.delayed(const Duration(seconds: 1));
      emit(ListFieldLoadedState(_dummyListFields));
    } catch (e) {
      emit(ListFieldErrorState("Failed to load list fields"));
    }
  }
}
