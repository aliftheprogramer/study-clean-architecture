import 'package:clean_architecture_poktani/features/profile/domain/entities/user_entity.dart';

abstract class ProfileDisplayState {}

class UserLoadingState extends ProfileDisplayState {}

class UserLoadedState extends ProfileDisplayState {
  final UserEntity userEntity;
  UserLoadedState({required this.userEntity});
}

class UserloadFailure extends ProfileDisplayState {
  final String errorMessage;
  UserloadFailure({required this.errorMessage});
}
