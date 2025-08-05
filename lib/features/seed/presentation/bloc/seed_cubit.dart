import 'package:clean_architecture_poktani/features/seed/domain/usecase/get_seeds_usecase.dart';
import 'package:clean_architecture_poktani/features/seed/presentation/bloc/seed_state.dart';
import 'package:clean_architecture_poktani/core/resources/data_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SeedCubit extends Cubit<SeedState> {
  final GetSeedsUseCase _getSeedsUseCase;

  SeedCubit(this._getSeedsUseCase) : super(SeedInitial());

  Future<void> fetchSeeds() async {
    emit(SeedLoading());
    final result = await _getSeedsUseCase();
    if (result is DataSuccess && result.data != null) {
      emit(SeedSuccess(result.data!.data));
    } else if (result is DataFailed) {
      emit(
        SeedFailure(
          result.error?.message ?? 'Terjadi kesalahan tidak diketahui',
        ),
      );
    }
  }
}
