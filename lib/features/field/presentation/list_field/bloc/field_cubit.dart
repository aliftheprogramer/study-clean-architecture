import 'package:clean_architecture_poktani/core/resources/data_state.dart';
import 'package:clean_architecture_poktani/core/services/services_locator.dart';
import 'package:clean_architecture_poktani/features/field/domain/entity/list_field_entity.dart';
import 'package:clean_architecture_poktani/features/field/domain/usecase/field_usecase.dart';
import 'package:clean_architecture_poktani/features/field/presentation/list_field/bloc/field_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListFieldCubit extends Cubit<ListFieldState> {
  final GetListFieldsUseCase _getListFieldsUseCase = sl<GetListFieldsUseCase>();

  ListFieldCubit() : super(ListFieldInitial());
  String? _nextPageUrl;

  Future<void> loadListFields() async {
    try {
      if (state is ListFieldLoading ||
          (state is ListFieldLoaded &&
              (state as ListFieldLoaded).hasReachedMax)) {
        return;
      }

      if (state is ListFieldInitial) {
        emit(ListFieldLoading());
      }

      final String? urlToFetch = (state is ListFieldInitial)
          ? null
          : _nextPageUrl;
      final dataState = await _getListFieldsUseCase(param: urlToFetch);

      if (dataState is DataSuccess && dataState.data != null) {
        final newFields = dataState.data!.fields;
        _nextPageUrl = dataState.data!.links?.next;
        final hasReachedMax = _nextPageUrl == null;

        // Jika state saat ini sudah loaded, tambahkan data baru ke list yang ada
        if (state is ListFieldLoaded) {
          final currentState = state as ListFieldLoaded;
          final updatedFields = List.of(currentState.fields)..addAll(newFields);
          emit(
            currentState.copyWith(
              fields: updatedFields,
              hasReachedMax: hasReachedMax,
            ),
          );
        } else {
          // Jika ini pemanggilan pertama, buat state loaded baru
          emit(
            ListFieldLoaded(fields: newFields, hasReachedMax: hasReachedMax),
          );
        }
      } else if (dataState is DataFailed) {
        emit(
          ListFieldError(
            dataState.error?.message ?? "An unknown error occurred",
          ),
        );
      }
    } catch (e) {
      emit(ListFieldError(e.toString()));
    }
  }
}
