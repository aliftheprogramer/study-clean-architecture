// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SignInReqParams {
  final String identifier;
  final String password;

  const SignInReqParams({required this.identifier, required this.password});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'identifier': identifier, 'password': password};
  }

  factory SignInReqParams.fromMap(Map<String, dynamic> map) {
    return SignInReqParams(
      identifier: map['identifier'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SignInReqParams.fromJson(String source) =>
      SignInReqParams.fromMap(json.decode(source) as Map<String, dynamic>);
}
