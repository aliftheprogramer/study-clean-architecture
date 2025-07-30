import 'package:clean_architecture_poktani/features/units/domain/usecase/get_units_usecase.dart';
import 'package:clean_architecture_poktani/features/units/presentation/bloc/unit_state.dart';
import 'package:clean_architecture_poktani/core/resources/data_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UnitCubit extends Cubit<UnitState> {
  final GetUnitsUseCase _getUnitsUseCase;

  UnitCubit(this._getUnitsUseCase) : super(UnitInitial());

  Future<void> fetchUnits() async {
    emit(UnitLoading());
    final result = await _getUnitsUseCase();
    if (result is DataSuccess && result.data != null) {
      emit(UnitSuccess(result.data!.data));
    } else if (result is DataFailed) {
      emit(
        UnitFailure(
          result.error?.message ?? 'Terjadi kesalahan tidak diketahui',
        ),
      );
    }
  }
}
