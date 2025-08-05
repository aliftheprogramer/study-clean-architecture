import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:clean_architecture_poktani/core/resources/data_state.dart';
import 'package:clean_architecture_poktani/core/services/services_locator.dart'; // <-- WAJIB IMPORT sl
import 'package:clean_architecture_poktani/features/map/domain/usecase/map_usecase.dart'; // <-- WAJIB IMPORT use case
import 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  // SEKARANG KONSTRUKTOR KOSONG, sama seperti ListFieldCubit Anda
  MapCubit() : super(MapInitial());

  Future<void> getAddressFromTap(LatLng point) async {
    // Ambil use case dari sl DI DALAM method, bukan dari konstruktor
    final getAddressUseCase = sl<GetAddressFromCoordinatesUseCase>();

    emit(MapLoading());

    // Panggil use case yang sudah diambil dari sl
    final dataState = await getAddressUseCase(
      lat: point.latitude,
      lon: point.longitude,
    );

    if (dataState is DataSuccess && dataState.data != null) {
      emit(MapLoaded(selectedLocation: point, address: dataState.data!));
    }

    if (dataState is DataFailed) {
      emit(MapError(dataState.error!.message ?? 'Gagal mengambil data alamat'));
    }
  }
}
