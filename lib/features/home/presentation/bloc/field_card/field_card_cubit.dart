// file: features/home/presentation/bloc/field_card/field_card_cubit.dart

import 'package:clean_architecture_poktani/core/resources/data_state.dart';
import 'package:clean_architecture_poktani/core/services/services_locator.dart';
import 'package:clean_architecture_poktani/features/field/domain/entity/list_field_entity.dart';
import 'package:clean_architecture_poktani/features/field/domain/usecase/field_usecase.dart';

import 'package:clean_architecture_poktani/features/home/presentation/bloc/field_card/field_card_state.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class FieldCardCubit extends Cubit<FieldCardState> {
  final GetListFieldsUseCase _getListFieldsUseCase = sl<GetListFieldsUseCase>();
  final ScrollController scrollController = ScrollController();

  String? _nextCursor;
  bool _isLoading = false; // Tambahkan 'kunci' ini

  FieldCardCubit() : super(FieldInitialState()) {
    scrollController.addListener(_onScroll);
    loadListFields();
  }

  void _onScroll() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent * 0.9) {
      loadListFields();
    }
  }

  Future<void> loadListFields() async {
    // Guard clause yang sudah aman dari race condition
    if (_isLoading ||
        (state is FieldLoadedState &&
            (state as FieldLoadedState).hasReachedMax)) {
      return;
    }

    _isLoading = true; // Kunci prosesnya

    try {
      final List<ListFieldEntity> currentFields = state is FieldLoadedState
          ? (state as FieldLoadedState).fields
          : [];
      if (state is FieldInitialState) {
        emit(FieldLoadingState());
      }

      final dataState = await _getListFieldsUseCase(param: _nextCursor);

      if (dataState is DataSuccess && dataState.data != null) {
        final newFields = dataState.data!.fields;
        _nextCursor = dataState.data!.paging?.cursors?.next;
        final hasReachedMax = _nextCursor == null;
        final allFields = currentFields + newFields;

        emit(FieldLoadedState(allFields, hasReachedMax: hasReachedMax));
      } else if (dataState is DataFailed) {
        emit(
          FieldErrorState(
            dataState.error?.message ?? "An unknown error occurred",
          ),
        );
      }
    } finally {
      _isLoading = false; // Pastikan kunci selalu terbuka setelah selesai
    }
  }

  @override
  Future<void> close() {
    scrollController.dispose();
    return super.close();
  }
}
