abstract class AddFieldState {}

class AddFieldInitial extends AddFieldState {}

class AddFieldLoading extends AddFieldState {}

class AddFieldSuccess extends AddFieldState {}

class AddFieldFailure extends AddFieldState {
  final String error;

  AddFieldFailure(this.error);
}
