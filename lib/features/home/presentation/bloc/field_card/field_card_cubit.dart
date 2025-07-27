import 'package:clean_architecture_poktani/core/resources/data_state.dart';
import 'package:clean_architecture_poktani/core/services/services_locator.dart';
import 'package:clean_architecture_poktani/features/home/domain/entity/field.dart';
import 'package:clean_architecture_poktani/features/home/domain/usecase/home_get_list_fields_use_case.dart';
import 'package:clean_architecture_poktani/features/home/presentation/bloc/field_card/field_card_state.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FieldCardCubit extends Cubit<FieldCardState> {
  final HomeGetListFieldsUseCase _getListFieldsUseCase =
      sl<HomeGetListFieldsUseCase>();

  final ScrollController scrollController = ScrollController();

  String? _nextPageUrl;

  FieldCardCubit() : super(FieldInitialState()) {
    // Add a listener when the cubit is created
    scrollController.addListener(_onScroll);
    // Load fields for the first time
    loadListFields();
  }

  void _onScroll() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent * 0.9) {
      loadListFields();
    }
  }

  Future<void> loadListFields() async {
    if (state is FieldLoadingState ||
        (state is FieldLoadedState &&
            (state as FieldLoadedState).hasReachedMax)) {
      return;
    }

    List<ItemFieldHomeEntity> currentFields = [];

    // Jika state saat ini sudah loaded, simpan data yang sudah ada
    if (state is FieldLoadedState) {
      currentFields = (state as FieldLoadedState).fields;
    }

    // Untuk loading pertama kali, emit state loading
    if (state is FieldInitialState) {
      emit(FieldLoadingState());
    }

    final dataState = await _getListFieldsUseCase(param: _nextPageUrl);
    if (dataState is DataSuccess && dataState.data != null) {
      final newFields = dataState.data!.data;
      _nextPageUrl = dataState.data!.links?.next;
      final hasReachedMax = _nextPageUrl == null;

      // Gabungkan data lama dengan data baru
      final allFields = currentFields + newFields;

      emit(
        FieldLoadedState(
          allFields, // Kirim list yang sudah digabung
          hasReachedMax: hasReachedMax,
        ),
      );
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
    scrollController.dispose(); // Jangan lupa dispose scrollController
    return super.close();
  }
}
