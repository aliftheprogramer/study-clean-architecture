class RegisterData {
  final String phone_number;
  final String password;
  final String password_confirmation;
  final String name;
  final String address;

  RegisterData({
    required this.phone_number,
    required this.password,
    required this.password_confirmation,
    this.name = '',
    this.address = '',
  });
}
