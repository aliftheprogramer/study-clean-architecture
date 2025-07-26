import 'package:clean_architecture_poktani/core/resources/data_state.dart';
import 'package:clean_architecture_poktani/core/services/services_locator.dart';
import 'package:clean_architecture_poktani/features/field/domain/entity/response/soil_type/response_soil_type_entitiy.dart';
import 'package:clean_architecture_poktani/features/field/domain/usecase/get_soil_type_usecase.dart';
import 'package:clean_architecture_poktani/features/field/presentation/get_soil_type/bloc/search_soil_type_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchSoilTypeCubit extends Cubit<SearchSoilTypeState> {
  final GetSoilTypeUsecase _getSoilTypeUsecase = sl<GetSoilTypeUsecase>();
  final ScrollController scrollController = ScrollController();
  SearchSoilTypeCubit() : super(SearchSoilTypeInitial()) {
    // Tambahkan listener saat cubit dibuat
    scrollController.addListener(_onScroll);
    // Panggil data pertama kali
    loadSoilTypes();
  }

  void _onScroll() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      loadSoilTypes();
    }
  }

  Future loadSoilTypes() async {
    if (state is SearchSoilTypeLoading ||
        (state is SearchSoilTypeLoaded &&
            (state as SearchSoilTypeLoaded).hasReachedMax)) {
      return;
    }
    // Tampilkan loading untuk pemanggilan pertama
    if (state is SearchSoilTypeInitial) {
      emit(SearchSoilTypeLoading("Loading soil types..."));
    }

    final dataState = await _getSoilTypeUsecase();
    if (dataState is DataSuccess && dataState.data != null) {
      final newSoilTypes = dataState.data!.data;
      final hasReachedMax = dataState.data!.links?.next == null;

      final currentSoilTypes = state is SearchSoilTypeLoaded
          ? (state as SearchSoilTypeLoaded).soilTypes
          : <SoilTypeEntitiy>[]; // Beri tipe eksplisit pada list kosong

      emit(
        SearchSoilTypeLoaded(
          soilTypes: List.of(currentSoilTypes)..addAll(newSoilTypes ?? []),
          hasReachedMax: hasReachedMax,
        ),
      );
    } else if (dataState is DataFailed) {
      emit(
        SearchSoilTypeError(
          dataState.error?.message ?? "An unknown error occurred",
        ),
      );
    }
  }
}
