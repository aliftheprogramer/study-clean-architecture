import 'package:clean_architecture_poktani/features/home/domain/entity/field.dart';
import 'package:clean_architecture_poktani/features/home/presentation/bloc/field_card/field_card_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FieldCardCubit extends Cubit<FieldCardState> {
  final List<Field> _dummyFields = dummyFields;

  FieldCardCubit() : super(FieldInitialState());

  Future<void> loadFields() async {
    try {
      emit(FieldLoadingState());
      // Simulate a network call or data fetching
      await Future.delayed(const Duration(seconds: 1));
      emit(FieldLoadedState(_dummyFields));
    } catch (e) {
      emit(FieldErrorState("Failed to load fields"));
    }
  }
}
