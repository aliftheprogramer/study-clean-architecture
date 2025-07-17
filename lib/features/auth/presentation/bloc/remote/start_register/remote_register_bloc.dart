import 'package:clean_architecture_poktani/features/auth/domain/entities/request/register/register_data.dart';
import 'package:clean_architecture_poktani/features/auth/presentation/bloc/remote/start_register/remote_regiser_state.dart';
import 'package:clean_architecture_poktani/features/auth/presentation/bloc/remote/start_register/remote_register_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class RemoteRegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RemoteRegisterBloc() : super(RegisterInitial()) {
    on<RegisterButtonPressed>((event, emit) async {
      try {
        emit(RegisterLoading());
        if (event.phoneNumber.isEmpty ||
            event.password.isEmpty ||
            event.passwordConfirmation.isEmpty) {
          emit(RegisterFailure(errorMessage: "All fields are required"));

          return;
        }

        if (event.password != event.passwordConfirmation) {
          emit(RegisterFailure(errorMessage: "Passwords do not match"));
          return;
        }

        final data = RegisterData(
          phone_number: event.phoneNumber,
          password: event.password,
          password_confirmation: event.passwordConfirmation,
        );
        emit(RegisterSuccess(registerData: data));
        // Simulate a network call or repository interaction
      } catch (e) {
        emit(RegisterFailure(errorMessage: e.toString()));
        return;
      }
    });
  }
}
