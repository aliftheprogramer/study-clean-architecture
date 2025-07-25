import 'package:clean_architecture_poktani/features/field/domain/entity/request/request_add_field.dart';
import 'package:clean_architecture_poktani/features/field/domain/usecase/add_field_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'add_field_state.dart';

class AddFieldCubit extends Cubit<AddFieldState> {
  // Ganti nama variabel biar lebih jelas
  final AddFieldUseCase _useCase;

  AddFieldCubit(this._useCase) : super(AddFieldInitial());

  Future<void> createField(AddFieldEntity params) async {
    emit(AddFieldLoading());

    // Panggil use case dengan parameter POSISIONAL, bukan NAMED
    // Bukan _useCase(AddFieldEntity: params), tapi _useCase(params)
    final result = await _useCase(params); // ✅ Ini yang bener

    // Karena use case sudah benar (mengembalikan Either), .fold() PASTI BISA
    result.fold(
      (gagal) {
        emit(
          AddFieldFailure(
            gagal.error?.message ?? 'Terjadi error tidak diketahui',
          ),
        );
      },
      (sukses) {
        // State sukses Anda tidak butuh data, jadi kita panggil constructornya saja
        emit(AddFieldSuccess());
      },
    );
  }
}
