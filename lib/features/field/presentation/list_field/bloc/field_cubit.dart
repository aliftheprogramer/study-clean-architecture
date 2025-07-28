// lib/features/field/presentation/list_field/bloc/field_cubit.dart

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
    scrollController.addListener(_onScroll);
    loadListFields();
  }

  void _onScroll() {
    if (state is ListFieldLoading) return; // Mencegah panggilan saat loading
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent * 0.9) {
      loadListFields();
    }
  }

  Future<void> loadListFields() async {
    // Guard clause untuk mencegah fetch jika sedang loading atau sudah maksimal
    if (state is ListFieldLoading ||
        (state is ListFieldLoaded &&
            (state as ListFieldLoaded).hasReachedMax)) {
      return;
    }

    // ================== LOGIKA BARU DITERAPKAN DI SINI ==================

    List<ListFieldEntity> currentFields = [];
    // Ambil data yang sudah ada jika state-nya ListFieldLoaded
    if (state is ListFieldLoaded) {
      currentFields = (state as ListFieldLoaded).fields;
    }

    // Tampilkan loading HANYA untuk pemanggilan pertama kali
    if (state is ListFieldInitial) {
      emit(ListFieldLoading());
    }

    final dataState = await _getListFieldsUseCase(param: _nextPageUrl);

    if (dataState is DataSuccess && dataState.data != null) {
      final newFields = dataState.data!.fields;
      _nextPageUrl = dataState.data!.links?.next;
      final hasReachedMax = _nextPageUrl == null;

      // Gabungkan list lama dan baru menggunakan operator '+'
      final allFields = currentFields + newFields;

      emit(ListFieldLoaded(fields: allFields, hasReachedMax: hasReachedMax));
    } else if (dataState is DataFailed) {
      emit(
        ListFieldError(dataState.error?.message ?? "An unknown error occurred"),
      );
    }
  }

  @override
  Future<void> close() {
    scrollController.dispose();
    return super.close();
  }
}
