import 'package:clean_architecture_poktani/core/resources/data_state.dart';
import 'package:clean_architecture_poktani/features/auth/domain/usecases/login_usecase.dart';
import 'package:clean_architecture_poktani/features/auth/presentation/bloc/remote/login/remote_login_event.dart';
import 'package:clean_architecture_poktani/features/auth/presentation/bloc/remote/login/remote_login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RemoteLoginBloc extends Bloc<RemoteLoginEvent, RemoteLoginState> {
  final LoginUsecase _loginUsecase;

  RemoteLoginBloc(this._loginUsecase) : super(const RemoteLoginLoading()) {
    on<SubmitLoginEvent>(onSubmitLoginEvent);
  }

  void onSubmitLoginEvent(
    SubmitLoginEvent event,
    Emitter<RemoteLoginState> emit,
  ) async {
    emit(const RemoteLoginLoading());

    final dataState = await _loginUsecase.call(params: event.loginData);

    if (dataState is DataSuccess && dataState.data != null) {
      emit(RemoteLoginSuccess(dataState.data!));
    }

    if (dataState is DataFailed) {
      emit(RemoteLoginFailure(dataState.error!));
    }
  }
}
