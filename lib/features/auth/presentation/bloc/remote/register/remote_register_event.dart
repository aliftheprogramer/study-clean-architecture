abstract class RegisterEvent {}

class RegisterButtonPressed extends RegisterEvent {
  final String phoneNumber;
  final String password;
  final String passwordConfirmation;

  RegisterButtonPressed({
    required this.phoneNumber,
    required this.password,
    required this.passwordConfirmation,
  });
}
