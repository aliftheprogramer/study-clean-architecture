// -- BLOC --
import 'package:clean_architecture_poktani/features/field/domain/entity/response/detail_field/response_detail_field_entity.dart';
import 'package:clean_architecture_poktani/features/field/presentation/detail_field/bloc/detail_field_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

class DetailFieldBloc extends Bloc<DetailFieldEvent, DetailFieldState> {
  DetailFieldBloc() : super(DetailFieldInitial()) {
    on<FetchDetailField>((event, emit) async {
      emit(DetailFieldLoading());
      try {
        await Future.delayed(const Duration(seconds: 1));

        // --- GANTI VARIABEL INI UNTUK MENGUJI SETIAP KONDISI ---
        final data = dummyDataNoFertilizer;

        Logger().i(
          'Menguji dengan data: ${data.keys.firstWhere((k) => data[k] == dummyDataFull['data'], orElse: () => 'unknown')}',
        );

        final fieldDetail = FieldDetailEntity.fromMap(
          data['data'] as Map<String, dynamic>,
        );
        emit(DetailFieldLoaded(fieldDetail));
      } catch (e, s) {
        Logger().e('!!! ERROR SAAT PARSING !!!', error: e, stackTrace: s);
        emit(DetailFieldError('Gagal memuat data lahan: $e'));
      }
    });
  }
}
