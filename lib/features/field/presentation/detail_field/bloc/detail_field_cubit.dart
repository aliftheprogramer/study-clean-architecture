// file: features/field/presentation/detail_field/bloc/detail_field_cubit.dart

import 'package:clean_architecture_poktani/core/resources/data_state.dart';
import 'package:clean_architecture_poktani/core/services/services_locator.dart';
import 'package:clean_architecture_poktani/features/field/domain/usecase/detail_field_usecase.dart';
import 'package:clean_architecture_poktani/features/field/presentation/detail_field/bloc/detail_field_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailFieldCubit extends Cubit<DetailFieldState> {
  final GetDetailFieldUseCase _getDetailFieldUseCase =
      sl<GetDetailFieldUseCase>();

  bool _isLoading = false;

  DetailFieldCubit() : super(DetailFieldInitial());

  Future<void> fetchDetailField(String fieldId) async {
    if (_isLoading) return;

    _isLoading = true;
    emit(DetailFieldLoading());

    try {
      final dataState = await _getDetailFieldUseCase(param: fieldId);
      if (dataState is DataSuccess && dataState.data != null) {
        emit(DetailFieldLoaded(dataState.data!.data));
      } else if (dataState is DataFailed) {
        emit(DetailFieldError(dataState.error.toString()));
      }
    } catch (e) {
      emit(DetailFieldError(e.toString()));
    } finally {
      _isLoading = false;
    }
  }
}
