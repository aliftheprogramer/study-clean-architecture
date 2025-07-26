import 'package:clean_architecture_poktani/features/field/domain/entity/request/request_add_field.dart';
import 'package:clean_architecture_poktani/features/field/domain/usecase/add_field_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:logger/logger.dart';
import 'add_field_state.dart';

class AddFieldCubit extends Cubit<AddFieldState> {
  final AddFieldUseCase _addFieldUseCase;

  AddFieldCubit(this._addFieldUseCase) : super(const AddFieldInitial());


  void updateSelectedLocation(LatLng location) {
    if (state is AddFieldInitial) {
      final currentState = state as AddFieldInitial;
      emit(currentState.copyWith(location: location));
    }
  }
  void nameChanged(String name) {
    if (state is AddFieldInitial) {
      emit((state as AddFieldInitial).copyWith(name: name));
    }
  }

  // 1. PERBAIKI METHOD INI
  void landAreaChanged(double value) {
    if (state is AddFieldInitial) {
      // Gunakan 'value' langsung tanpa parsing
      emit((state as AddFieldInitial).copyWith(landArea: value));
    }
  }

  void locationChanged({
    required LatLng location,
    required String subVillage,
    required String village,
    required String district,
  }) {
    if (state is AddFieldInitial) {
      final currentState = state as AddFieldInitial;
      emit(
        currentState.copyWith(
          location: location,
          subVillage: subVillage,
          village: village,
          district: district,
        ),
      );
    }
  }

  void soilTypeChanged(int id) {
    if (state is AddFieldInitial) {
      final currentState = state as AddFieldInitial;
      emit(currentState.copyWith(soilTypeId: id));
    }
  }

  void subVillageChanged(String subVillage) {
    if (state is AddFieldInitial) {
      final currentState = state as AddFieldInitial;
      emit(currentState.copyWith(subVillage: subVillage));
    }
  }

  void villageChanged(String village) {
    if (state is AddFieldInitial) {
      final currentState = state as AddFieldInitial;
      emit(currentState.copyWith(village: village));
    }
  }

  void districtChanged(String district) {
    if (state is AddFieldInitial) {
      final currentState = state as AddFieldInitial;
      emit(currentState.copyWith(district: district));
    }
  }

  // 2. GANTI NAMA METHOD AGAR LEBIH JELAS
  Future<void>  submitField() async {
    if (state is AddFieldInitial) {
      final currentState = state as AddFieldInitial;
      Logger().d(
        'Mencoba mengirim data lahan baru:\n'
        '  Nama Lahan: ${currentState.name}\n'
        '  Luas: ${currentState.landArea} m²\n'
        '  Lokasi: ${currentState.location}\n'
        '  Jenis Tanah ID: ${currentState.soilTypeId}\n'
        '  Dusun: ${currentState.subVillage}\n'
        '  Desa: ${currentState.village}\n'
        '  Kecamatan: ${currentState.district}',
      );
      emit(AddFieldLoading());

      final params = AddFieldEntity(
        name: currentState.name,
        landArea: currentState.landArea,
        latitude: currentState.location?.latitude.toString() ?? '',
        longitude: currentState.location?.longitude.toString() ?? '',
        subVillage: currentState.subVillage,
        village: currentState.village,
        district: currentState.district,
        soilTypeId: currentState.soilTypeId,
      );

      final result = await _addFieldUseCase(param: params);

      result.fold(
        (gagal) {
          emit(
            AddFieldFailure(
              gagal.error?.message ?? 'Terjadi error tidak diketahui',
            ),
          );
        },
        (sukses) {
          emit(AddFieldSuccess());
        },
      );
    }
  }
}
