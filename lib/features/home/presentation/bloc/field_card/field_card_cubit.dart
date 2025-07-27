import 'package:clean_architecture_poktani/core/resources/data_state.dart';
import 'package:clean_architecture_poktani/core/services/services_locator.dart';
import 'package:clean_architecture_poktani/features/home/domain/usecase/home_get_list_fields_use_case.dart';
import 'package:clean_architecture_poktani/features/home/presentation/bloc/field_card/field_card_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FieldCardCubit extends Cubit<FieldCardState> {
  final HomeGetListFieldsUseCase _getListFieldsUseCase =
      sl<HomeGetListFieldsUseCase>();
  FieldCardCubit() : super(FieldInitialState());

  Future<void> loadListFields() async {
    if (state is FieldLoadingState) {
      return;
    }

    if (state is FieldInitialState) {
      emit(FieldLoadingState());
    }

    final dataState = await _getListFieldsUseCase();
    if (dataState is DataSuccess && dataState.data != null) {
      final newData = dataState.data!.data;

      emit(FieldLoadedState(newData));
    } else if (dataState is DataFailed) {
      emit(
        FieldErrorState(
          dataState.error?.message ?? "An unknown error occurred",
        ),
      );
    }
  }

  @override
  Future<void> close() {
    // Dispose of any resources if necessary
    return super.close();
  }
}
