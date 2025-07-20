import 'package:clean_architecture_poktani/core/services/services_locator.dart';
import 'package:clean_architecture_poktani/features/profile/domain/usecase/get_user.dart';
import 'package:clean_architecture_poktani/features/profile/presentation/bloc/user_display_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileDisplayCubit extends Cubit<ProfileDisplayState> {
  ProfileDisplayCubit() : super(UserLoadingState());

  void displayProfile() async {
    emit(UserLoadingState());
    var result = await sl<GetUserUseCase>().call();
    result.fold(
      (error) {
        emit(UserloadFailure(errorMessage: error));
      },
      (data) {
        emit(UserLoadedState(userEntity: data));
      },
    );
  }
}
