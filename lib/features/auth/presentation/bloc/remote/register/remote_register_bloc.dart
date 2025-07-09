import 'package:clean_architecture_poktani/core/resources/data_state.dart';
import 'package:clean_architecture_poktani/features/auth/domain/usecases/register_usecase.dart';
import 'package:clean_architecture_poktani/features/auth/presentation/bloc/remote/register/remote_register_event.dart';
import 'package:clean_architecture_poktani/features/auth/presentation/bloc/remote/register/remote_register_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RemoteRegisterBloc
    extends Bloc<RemoteRegisterEvent, RemoteRegisterState> {
  final RegisterUsecase _registerUsecase;

  RemoteRegisterBloc(this._registerUsecase)
    : super(const RemoteRegisterLoading()) {
    on<SubmitRegisterEvent>(onSubmitRegisterEvent);
  }

  void onSubmitRegisterEvent(
    SubmitRegisterEvent event,
    Emitter<RemoteRegisterState> emit,
  ) async {
    emit(const RemoteRegisterLoading());

    final dataState = await _registerUsecase.call(params: event.registerData);

    if (dataState is DataSuccess && dataState.data != null) {
      emit(RemoteRegisterSuccess(dataState.data!));
    }

    if (dataState is DataFailed) {
      emit(RemoteRegisterFailure(dataState.error!));
    }
  }
}
