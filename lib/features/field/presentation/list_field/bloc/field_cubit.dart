import 'package:clean_architecture_poktani/core/resources/data_state.dart';
import 'package:clean_architecture_poktani/core/services/services_locator.dart';
import 'package:clean_architecture_poktani/features/field/domain/entity/list_field_entity.dart';
import 'package:clean_architecture_poktani/features/field/domain/usecase/field_usecase.dart';
import 'package:clean_architecture_poktani/features/field/presentation/list_field/bloc/field_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListFieldCubit extends Cubit<ListFieldState> {
  final GetListFieldsUseCase _getListFieldsUseCase = sl<GetListFieldsUseCase>();
  final ScrollController scrollController = ScrollController();

  String? _nextPageUrl;

  ListFieldCubit() : super(ListFieldInitial()) {
    // Tambahkan listener saat cubit dibuat
    scrollController.addListener(_onScroll);
    // Panggil data pertama kali
    loadListFields();
  }

  void _onScroll() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent * 0.9) {
      loadListFields();
    }
  }

  Future<void> loadListFields() async {
    if (state is ListFieldLoading ||
        (state is ListFieldLoaded &&
            (state as ListFieldLoaded).hasReachedMax)) {
      return;
    }

    // Tampilkan loading untuk pemanggilan pertama
    if (state is ListFieldInitial) {
      emit(ListFieldLoading());
    }

    final dataState = await _getListFieldsUseCase(param: _nextPageUrl);

    if (dataState is DataSuccess && dataState.data != null) {
      final newFields = dataState.data!.fields;
      _nextPageUrl = dataState.data!.links?.next;
      final hasReachedMax = _nextPageUrl == null;

      final currentFields = state is ListFieldLoaded
          ? (state as ListFieldLoaded).fields
          : <ListFieldEntity>[]; // Beri tipe eksplisit pada list kosong

      emit(
        ListFieldLoaded(
          fields: List.of(currentFields)..addAll(newFields),
          hasReachedMax: hasReachedMax,
        ),
      );
    } else if (dataState is DataFailed) {
      emit(
        ListFieldError(dataState.error?.message ?? "An unknown error occurred"),
      );
    }
  }

  // Pastikan untuk membuang controller saat cubit ditutup
  @override
  Future<void> close() {
    scrollController.dispose();
    return super.close();
  }
}
