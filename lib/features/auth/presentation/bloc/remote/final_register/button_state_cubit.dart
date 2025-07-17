import 'package:clean_architecture_poktani/core/usecases/usecase.dart';
import 'package:clean_architecture_poktani/features/auth/presentation/bloc/remote/final_register/button_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ButtonStateCubit extends Cubit<ButtonState> {
  ButtonStateCubit() : super(ButtonInitialState());

  void execute({dynamic params, required Usecase usecase}) async {
    try {
      Either result = await usecase.call(param: params);
      result.fold(
        (error) {
          emit(ButtonFailureState(errorMessage: error));
        },
        (data) {
          emit(ButtonSuccessState());
        },
      );
    } catch (e) {
      emit(ButtonFailureState(errorMessage: e.toString()));
    }
  }
}
