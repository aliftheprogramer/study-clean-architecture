// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SignupReqParams {
  final String name;
  final String password;
  final String password_confirmation;
  final String? phone_number;
  final String? email;
  final String? address;
  SignupReqParams({
    required this.name,
    required this.password,
    required this.password_confirmation,
    required this.phone_number,
    required this.address,
    this.email = '',
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'password': password,
      'password_confirmation': password_confirmation,
      'phone_number': phone_number,
      'email': email,
      'address': address,
    };
  }

  factory SignupReqParams.fromMap(Map<String, dynamic> map) {
    return SignupReqParams(
      name: map['name'] as String,
      password: map['password'] as String,
      password_confirmation: map['password_confirmation'] as String,
      phone_number: map['phone_number'] != null
          ? map['phone_number'] as String
          : null,
      email: map['email'] != null ? map['email'] as String : null,
      address: map['address'] != null ? map['address'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SignupReqParams.fromJson(String source) =>
      SignupReqParams.fromMap(json.decode(source) as Map<String, dynamic>);
}
